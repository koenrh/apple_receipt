# frozen_string_literal: true

require 'openssl'

module AppleReceipt
  # Validator allows one to check the validity of a receipt.
  class Validator
    def initialize(receipt, certificates: [])
      populate_certificate_store(receipt.version, certificates)
      @receipt = receipt
    end

    def populate_certificate_store(version, provided_certificates)
      certificates = if provided_certificates.any?
                       provided_certificates
                     else
                       default_chain(version)
                     end
      add_certificates(certificates)
    end

    def default_chain(version)
      root_cert_pem = File.read('./certificates/AppleIncRootCertificate.cer')
      intermediate_cert_pem = case version
                              when 3
                                File.read('./certificates/AppleWWDRCA.cer')
                              when 2
                                File.read('./certificates/AppleISCA.cer')
                              end

      [OpenSSL::X509::Certificate.new(root_cert_pem),
       OpenSSL::X509::Certificate.new(intermediate_cert_pem)]
    end

    def add_certificates(certificates)
      certificates.each do |cert|
        store.add_cert(cert)
      end
    end

    def valid?
      store.verify(receipt.certificate) &&
        public_key.verify(OpenSSL::Digest::SHA1.new,
                          receipt.signature, signed_data)
    end

    def public_key
      receipt.certificate.public_key
    end

    def signed_data
      [receipt.version, receipt.data].pack('CA*')
    end

    def store
      @store ||= OpenSSL::X509::Store.new
    end

    private

    attr_reader :receipt
  end
end

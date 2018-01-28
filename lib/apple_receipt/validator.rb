# frozen_string_literal: true

require 'openssl'

module AppleReceipt
  # Validator allows one to check the validity of a receipt.
  class Validator
    INTERMEDIATE_CERT_MAPPING = {
      3 => 'AppleWorldwideDeveloperRelationsCertificationAuthority',
      2 => 'AppleITunesStoreCertificationAuthority'
    }.freeze

    def initialize(receipt, certificates: [])
      populate_certificate_store(receipt.version, certificates)
      @receipt = receipt
    end

    def populate_certificate_store(version, provided_certificates)
      if provided_certificates.any?
        add_certificates(provided_certificates)
      else
        add_named_certificate('AppleRootCA')
        add_named_certificate(INTERMEDIATE_CERT_MAPPING[version])
      end
    end

    def add_named_certificate(name)
      cert_path = File.expand_path("../../certificates/#{name}.cer", __dir__)
      cert_file = File.read(cert_path)
      store.add_cert(OpenSSL::X509::Certificate.new(cert_file))
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

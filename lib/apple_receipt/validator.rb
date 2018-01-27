# frozen_string_literal: true

require 'openssl'

module AppleReceipt
  # Validator allows one to check the validity of a receipt.
  class Validator
    def initialize(receipt)
      root_cert_pem = File.read('./certificates/AppleIncRootCertificate.cer')
      root_cert = OpenSSL::X509::Certificate.new(root_cert_pem)

      intermediate_cert_pem = File.read('./certificates/AppleWWDRCA.cer')
      intermediate_cert = OpenSSL::X509::Certificate.new(intermediate_cert_pem)

      store.add_cert(root_cert)
      store.add_cert(intermediate_cert)

      @receipt = receipt
    end

    def valid?
      store.verify(receipt.cert) &&
        public_key.verify(OpenSSL::Digest::SHA1.new,
                          receipt.signature, signed_data)
    end

    def public_key
      receipt.cert.public_key
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

# frozen_string_literal: true

require 'base64'
require 'openssl'
require 'json'
require 'set'

require 'apple_receipt/next_step_parser'

module AppleReceipt
  # ReceiptParser contains helper methods to parse receipt data structures.
  module ReceiptParser
    module_function

    SIGNATURE_LENGTH_MAPPING = {
      2 => 128,
      3 => 256
    }.freeze

    def parse(input)
      receipt_hash = NextStepParser.parse(input)

      unless Set['signature', 'purchase-info'].subset?(receipt_hash.keys.to_set)
        raise ArgumentError, 'Missing required fields'
      end

      signature_decoded = Base64.decode64(receipt_hash['signature'])
      data_decoded = Base64.decode64(receipt_hash['purchase-info'])

      version, signature, receipt_cert = read_signature(signature_decoded)
      [version, signature, receipt_cert, data_decoded]
    end

    def read_signature(signature_decoded)
      sig = StringIO.new(signature_decoded)
      version = sig.read(1).unpack('C').first # 8-bit unsigned (unsigned char)

      unless SIGNATURE_LENGTH_MAPPING.keys.include?(version)
        raise ArgumentError, "Unsupported receipt version: #{version}"
      end

      signature = sig.read(SIGNATURE_LENGTH_MAPPING[version])
      cert_size = sig.read(4).unpack('L>')[0] # 32-bit unsigned, big-endian
      receipt_cert = OpenSSL::X509::Certificate.new(sig.read(cert_size))

      [version, signature, receipt_cert]
    end
  end
end

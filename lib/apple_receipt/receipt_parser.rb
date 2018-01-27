# frozen_string_literal: true

require 'base64'
require 'openssl'
require 'json'

require 'apple_receipt/next_step_parser'

module AppleReceipt
  # ReceiptParser contains helper methods to parse receipt data structures.
  module ReceiptParser
    module_function

    def bla(input)
      receipt_hash = NextStepParser.parse(input)
      signature_decoded = Base64.decode64(receipt_hash['signature'])
      data = Base64.decode64(receipt_hash['purchase-info'])

      sig = StringIO.new(signature_decoded)
      [sig, data]
    end

    def parse(input)
      sig, data = bla(input)

      version = sig.read(1).unpack('C').first # 8-bit unsigned (unsigned char)
      signature = sig.read(256)
      cert_size = sig.read(4).unpack('L>')[0] # 32-bit unsigned, big-endian
      receipt_cert = OpenSSL::X509::Certificate.new(sig.read(cert_size))

      [version, signature, receipt_cert, data]
    end
  end
end

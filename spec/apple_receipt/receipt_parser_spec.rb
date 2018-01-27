# frozen_string_literal: true

require 'spec_helper'

require 'apple_receipt/receipt_parser'

describe AppleReceipt::ReceiptParser do
  describe '.parse' do
    it 'parses a raw receipt' do
      signature = Base64.strict_encode64('abc')
      purchase_info = Base64.strict_encode64('baz')
      data = "{\n\t\"signature\" = \"#{signature}\";\n"\
        "\t\"purchase-info\" = \"#{purchase_info}\";\n}"

      AppleReceipt::ReceiptParser.expects(:read_signature)
                                 .with('abc')
                                 .returns([1, 2, 3])
      receipt_data = AppleReceipt::ReceiptParser.parse(data)
      receipt_data.must_equal([1, 2, 3, 'baz'])
    end

    it 'raises an error when a required field is missing' do
      err = lambda do
        AppleReceipt::ReceiptParser.parse('{}')
      end.must_raise ArgumentError
      err.message.must_equal 'Missing required fields'
    end

    it 'raises an error for unsupported versions' do
      test = [4].pack('C')
      err = lambda do
        AppleReceipt::ReceiptParser.read_signature(test)
      end.must_raise ArgumentError
      err.message.must_equal 'Unsupported receipt version: 4'
    end

    it 'parses a valid receipt' do
      valid_receipt_raw = File.read('./spec/fixtures/valid_receipt.txt')
      valid_receipt = Base64.decode64(valid_receipt_raw)
      v, size, cert, data = AppleReceipt::ReceiptParser.parse(valid_receipt)

      v.must_equal 3
      size.length.must_equal 256
      cert.subject.to_s.must_equal '/'\
        'CN=Mac App Store and iTunes Store Receipt Signing/'\
        'OU=Apple Worldwide Developer Relations/'\
        'O=Apple Inc./'\
        'C=US'
      data.wont_equal nil
    end
  end
end

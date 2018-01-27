# frozen_string_literal: true

require 'spec_helper'

require 'apple_receipt/receipt_parser'

describe AppleReceipt::ReceiptParser do
  describe '.parse' do
    it 'parses the receipt' do
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

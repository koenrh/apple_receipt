# frozen_string_literal: true

require 'spec_helper'

require 'apple_receipt/receipt'

describe AppleReceipt::Receipt do
  describe '#valid?' do
    it 'indicates whether the receipt is valid' do
      latest_receipt_raw = File.read('./spec/fixtures/valid_receipt.txt')
      receipt = AppleReceipt::Receipt.new(latest_receipt_raw)
      receipt.valid?.must_equal true
    end
  end
end

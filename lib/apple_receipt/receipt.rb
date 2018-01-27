# frozen_string_literal: true

require 'base64'

require 'apple_receipt/next_step_parser'
require 'apple_receipt/receipt_parser'
require 'apple_receipt/validator'

module AppleReceipt
  # Receipt represents an Apple receipt.
  class Receipt
    def initialize(raw_receipt)
      receipt_decoded = Base64.decode64(raw_receipt)
      @version, @signature, @cert, @data = ReceiptParser.parse(receipt_decoded)
    end

    def purchase_info
      NextStepParser.parse(data)
    end

    def valid?
      Validator.new(self).valid?
    end

    attr_reader :version, :signature, :cert, :data
  end
end

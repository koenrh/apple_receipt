# frozen_string_literal: true

require 'spec_helper'

require 'apple_receipt/receipt'

describe AppleReceipt::Receipt do
  let(:receipt_raw) { File.read('./spec/fixtures/valid_receipt.txt') }

  describe '#valid?' do
    it 'indicates whether the receipt is valid' do
      receipt = AppleReceipt::Receipt.new(receipt_raw)
      receipt.valid?.must_equal true
    end
  end

  describe '#purchase_info' do
    # rubocop:disable Metrics/LineLength
    it 'returns the purchase information as a hash' do
      receipt = AppleReceipt::Receipt.new(receipt_raw)
      receipt.purchase_info.must_equal(
        'original_purchase_date_pst' => '2017-12-23 09:03:53 America/Los_Angeles',
        'quantity' => '1',
        'unique_vendor_identifier' => 'D895D8DB-AEDF-4530-B7E5-E0C9A9A394B6',
        'original_purchase_date_ms' => '1514048633000',
        'expires_date_formatted' => '2018-01-23 17:03:44 Etc/GMT',
        'is_in_intro_offer_period' => 'false',
        'purchase_date_ms' => '1514048624000',
        'expires_date_formatted_pst' => '2018-01-23 09:03:44 America/Los_Angeles',
        'is_trial_period' => 'false',
        'item_id' => '1190360447',
        'unique_identifier' => 'fed543dc24065fa2ab23ef08b0b44c0a0c9ed375',
        'original_transaction_id' => '160000408504141',
        'expires_date' => '1516727024000',
        'app_item_id' => '947936149',
        'transaction_id' => '160000408504141',
        'bvrs' => '7000',
        'web_order_line_item_id' => '160000091314729',
        'version_external_identifier' => '825366855',
        'bid' => 'com.blendle.trending',
        'product_id' => 'com.blendle.trending.premium_subscription.monthly',
        'purchase_date' => '2017-12-23 17:03:44 Etc/GMT',
        'purchase_date_pst' => '2017-12-23 09:03:44 America/Los_Angeles',
        'original_purchase_date' => '2017-12-23 17:03:53 Etc/GMT'
      )
    end
    # rubocop:enable Metrics/LineLength
  end
end

# AppleReceipt

[![Build Status](https://travis-ci.org/koenrh/apple_receipt.svg?branch=master)](https://travis-ci.org/koenrh/apple_receipt)
[![Dependency Status](https://beta.gemnasium.com/badges/github.com/koenrh/apple_receipt.svg)](https://beta.gemnasium.com/projects/github.com/koenrh/apple_receipt)

This gem allows you to to locally/cryptographically verify Apple receipts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple_receipt'
```

And then execute:

    bundle

Or install it yourself as:

    gem install apple_receipt

## Usage

```ruby
require 'apple_receipt'

# check validity (certificate chain, and signature)
receipt_raw = File.read('./receipt.txt')
receipt = AppleReceipt::Receipt.new(receipt_raw)
receipt.valid?
# => true

# read purchase info
receipt.purchase_info
# => {"original-purchase-date-pst"=>"2017-12-23 09:03:53 America/Los_Angeles",
#  "quantity"=>"1",
#  "unique-vendor-identifier"=>"D895D8DB-AEDF-4530-B7E5-E0C9A9A394B6",
#  "original-purchase-date-ms"=>"1514048633000",
#  "expires-date-formatted"=>"2018-01-23 17:03:44 Etc/GMT",
#  "is-in-intro-offer-period"=>"false",
#  "purchase-date-ms"=>"1514048624000",
#  "expires-date-formatted-pst"=>"2018-01-23 09:03:44 America/Los_Angeles",
#  "is-trial-period"=>"false",
#  "item-id"=>"1190360447",
#  "unique-identifier"=>"fed543dc24065fa2ab23ef08b0b44c0a0c9ed375",
#  "original-transaction-id"=>"160000408504141",
#  "expires-date"=>"1516727024000",
#  "app-item-id"=>"947936149",
#  "transaction-id"=>"160000408504141",
#  "bvrs"=>"7000",
#  "web-order-line-item-id"=>"160000091314729",
#  "version-external-identifier"=>"825366855",
#  "bid"=>"com.foo.bar",
#  "product-id"=>"com.foo.bar.monthly",
#  "purchase-date"=>"2017-12-23 17:03:44 Etc/GMT",
#  "purchase-date-pst"=>"2017-12-23 09:03:44 America/Los_Angeles",
#  "original-purchase-date"=>"2017-12-23 17:03:53 Etc/GMT"}
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/koenrh/apple_receipt).
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org)
code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

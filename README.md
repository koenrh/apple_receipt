# AppleReceipt

[![Build Status](https://travis-ci.org/koenrh/apple_receipt.svg?branch=master)](https://travis-ci.org/koenrh/apple_receipt)

This gem allows you to to locally/cryptographically verify Apple receipts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple_receipt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apple_receipt

## Usage

```ruby
require 'apple_receipt'

# check validity (certificate chain, and signature)
receipt_raw = File.read('./receipt.txt')
receipt = AppleReceipt::Receipt.new(receipt_raw)
receipt.valid?

# read purchase info
receipt.data
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/koenrh/apple_receipt). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

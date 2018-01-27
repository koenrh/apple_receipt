# Apple Receipt

[![Gem Version](https://badge.fury.io/rb/apple_receipt.svg)](https://badge.fury.io/rb/apple_receipt)
[![Build Status](https://travis-ci.org/koenrh/apple_receipt.svg?branch=master)](https://travis-ci.org/koenrh/apple_receipt)
[![Dependency Status](https://beta.gemnasium.com/badges/github.com/koenrh/apple_receipt.svg)](https://beta.gemnasium.com/projects/github.com/koenrh/apple_receipt)

This gem allows you to read the data embedded in Apple receipt, and locally verify its integrity, and authenticity. It was originally built to verify the validity of receipts embedded in Apple's '[Status Update Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Subscriptions.html#//apple_ref/doc/uid/TP40008267-CH7-SW13)'.

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

# Check receipt's validity (certificate chain, and signature)
receipt_raw = File.read('./receipt.txt')
receipt = AppleReceipt::Receipt.new(receipt_raw)
receipt.valid?
# => true

# Read receipt's data (data in example shortened for brevity)
receipt.purchase_info
# => {
#   "quantity"=>"1",
#   "expires-date-formatted"=>"2018-01-23 17:03:44 Etc/GMT",
#   "is-in-intro-offer-period"=>"false",
#   "is-trial-period"=>"false",
#   "item-id"=>"1190360447",
#   "app-item-id"=>"947936149",
#   "transaction-id"=>"160000408504141",
#   "web-order-line-item-id"=>"160000011000001",
#   "bid"=>"com.foo.bar",
#   "product-id"=>"com.foo.bar.monthly",
#   "purchase-date"=>"2017-12-23 17:03:44 Etc/GMT",
#   "original-purchase-date"=>"2017-12-23 17:03:53 Etc/GMT"
# }
```

## Apple receipts

A receipt is encoded as base64, and is formatted as a [NeXTSTEP](https://en.wikipedia.org/wiki/Property_list#NeXTSTEP)
dictionary:

```
{
  "signature" = "[base64-encoded signature]";
  "purchase-info" = "[base64-encoded purchase data]";
  "pod" = "[integer]";
  "signing-status" = "0";
}
```

### Signature

The `signature` entry contains base64-encoded binary data, which has the following
layout:

- **1 byte** - Receipt version (e.g. version 3).
- **128 bytes** (version 2) or **256 bytes** (version 3) - Signature.
- **4 bytes** - Length (in number of bytes) of the certificate.
- **N bytes** - DER-encoded certificate.

The version 2 and 3 receipt certificates are signed, respectively, by:

- **Apple iTunes Store Certification Authority** (version 2)
  - Serial: 26 (`0x1a`)
  - Subject: `C=US, O=Apple Inc., OU=Apple Certification Authority, CN=Apple iTunes Store Certification Authority`
- **Apple Worldwide Developer Relations Certification Authority** (version 3)
  - Serial: 134752589830791184 (`0x1debcc4396da010`)
  - Subject: `C=US, O=Apple Inc., OU=Apple Worldwide Developer Relations, CN=Apple Worldwide Developer Relations Certification Authority`

Both certificates chain up to:

- **Apple Root CA**
  - Serial: 2 (`0x2`)
  - Subject: `C=US, O=Apple Inc., OU=Apple Certification Authority, CN=Apple Root CA`

### Purchase info

The `purchase-info` entry contains a base64-encoded NeXTSTEP dictionary that contains the actual receipt data (purchase info).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/koenrh/apple_receipt).
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org)
code of conduct.

## License

The gem is available as open source under the terms of the [ISC License](https://opensource.org/licenses/ISC).

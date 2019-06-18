# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apple_receipt/version'

Gem::Specification.new do |spec|
  spec.name          = 'apple_receipt'
  spec.version       = AppleReceipt::VERSION
  spec.authors       = ['Koen Rouwhorst']
  spec.email         = ['info@koenrouwhorst.nl']

  spec.summary       = 'Local Apple receipt validation.'
  # spec.description   = %q{TODO: Write a longer description or delete this li
  spec.homepage      = 'https://github.com/koenrh/apple_receipt'
  spec.license       = 'ISC'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '~> 2.0'
  spec.add_dependency 'openssl', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop', '~> 0.60'
end

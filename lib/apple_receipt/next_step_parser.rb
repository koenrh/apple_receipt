# frozen_string_literal: true

require 'json'

module AppleReceipt
  # NextStepParser parses NextSTEP Plist data structures.
  module NextStepParser
    module_function

    def parse(input)
      # Transform JSON-like NextSTEP PList data into JSON
      raw_json = input.gsub(/;\n\t/, ",\n\t")
                      .gsub(/\ =/, ':')
                      .gsub(/;\n/, '')
      h = JSON.parse(raw_json)
      h.transform_keys { |k| k.tr('-', '_') }
    end
  end
end

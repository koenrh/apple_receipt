# frozen_string_literal: true

require 'spec_helper'

require 'apple_receipt/next_step_parser'

describe AppleReceipt::NextStepParser do
  describe '.parse' do
    it 'transforms nextstep data into a hash' do
      nextstep = "{\n"\
        "\t\"foo\" = \"abc\";\n"\
        "\t\"bar\" = \"baz\";\n}"

      data = AppleReceipt::NextStepParser.parse(nextstep)
      data.must_equal('foo' => 'abc', 'bar' => 'baz')
    end

    it 'replaces dashes with underscores in keys' do
      nextstep = "{\n"\
        "\t\"foo-bar\" = \"baz\";\n}"

      data = AppleReceipt::NextStepParser.parse(nextstep)
      data.must_equal('foo_bar' => 'baz')
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

require 'apple_receipt/next_step_parser'

describe AppleReceipt::NextStepParser do
  describe '.parse' do
    it 'transforms nextstep data into a hash' do
      # sig_b64 = Base64.encode64('abc').delete("\n")
      # data_b64 = Base64.encode64('123').delete("\n")
      nextstep = "{\n"\
        "\t\"foo\" = \"abc\";\n"\
        "\t\"bar\" = \"baz\";\n}"

      data = AppleReceipt::NextStepParser.parse(nextstep)
      data.must_equal('foo' => 'abc', 'bar' => 'baz')
    end
  end
end

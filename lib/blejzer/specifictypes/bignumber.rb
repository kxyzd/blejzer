# frozen_string_literal: true

module Blejzer
  class SpecificBigNumber
    RANGE = (9_223_372_036_854_775_807..)

    def initialize(number)
      @value = number.to_s
    end

    def dump
      header + @value + SpecificString::END_OF_STRING
    end

    def self.load(bin)
      _, bin = Dumper.header(1)[bin]
      header_string = Dumper.code CStr

      SpecificString.load(
        header_string + bin
      ) => [num_str, bin]

      [num_str.to_i, bin]
    end

    private

    def header
      Dumper.code BigNumber
    end
  end
end

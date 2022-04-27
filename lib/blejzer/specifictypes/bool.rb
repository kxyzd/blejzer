# frozen_string_literal: true

module Blejzer
  class SpecificBool
    def initialize(bool)
      @bool = bool
    end

    def dump
      Dumper.code(@bool ? BTrue : BFalse)
    end

    def self.load(bin)
      code, bin = Dumper.header(1)[bin]

      [
        code == BTrue.code,
        bin
      ]
    end
  end
end

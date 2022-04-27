# frozen_string_literal: true

module Blejzer
  class SpecificNil
    def initialize(_); end

    def dump
      Dumper.code(Null)
    end

    def self.load(bin)
      code, bin = Dumper.header(1)[bin]

      # TODO: *_*
      raise 'aaaaa' unless code == Null.code

      [nil, bin]
    end
  end
end

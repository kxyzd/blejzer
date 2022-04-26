# frozen_string_literal: true

module Blejzer
  class SpecificString
    END_OF_STRING = [0].pack('C')

    def initialize(string)
      @string = string
    end

    def dump
      header + @string + END_OF_STRING
    end

    def self.load(bin)
      _, bin = Dumper.header(1)[bin]
      [
        string = bin
                 .bytes
                 .take_while { _1 != 0 }
                 .pack('C*')
                 .force_encoding('UTF-8'),
        bin[string.size.succ..] # `.succ` because `\0`.
      ]
    end

    private

    def header
      Dumper.code CStr
    end
  end
end

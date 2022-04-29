# frozen_string_literal: true

module Blejzer
  class SpecificInteger
    def initialize(number)
      @value = number
      _, @type, @directive, * = what_is_the_type
    end

    def dump
      @bin ||= header + [@value].pack(@directive)
    end

    def self.load(bin)
      code, bin = Dumper.header(1)[bin]

      # TODO: Add more checkers.
      raise 'uncorrected code in SpecificInteger' unless correct_code?(code)

      _, _, directive, * = find_specific_type_by_code(code)

      *, sizetype = find_specific_type_by_code(code)

      [
        Dumper.unpack(bin, directive),
        bin[sizetype..]
      ]
    end

    def size
      dump.size
    end

    def metatype
      @type
    end

    private

    def header
      Dumper.code @type
    end

    def what_is_the_type
      Blejzer::TNumber.find { |(range, _, _)| range.include? @value }
    end

    class << self
      def correct_code?(code)
        Blejzer::TNumber.any? { |(_, type, _)| type.code == code }
      end

      def find_specific_type_by_code(code)
        Blejzer::TNumber.find { |(_, type, _)| type.code == code }
      end
    end
  end
end

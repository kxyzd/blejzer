# frozen_string_literal: true

module Blejzer
  class UOArray
    def initialize(array)
      @array = array
      @types = array.map(&Dumper.method(:what_is_the_specific_type))
      @values = @array.zip(@types)
                      .map { |(val, type)| type.new(val) }
    end

    def dump
      body = @values.map(&:dump).join
      header(body) + body
    end

    def self.load(bin)
      # TODO: Check on Errors.
      _, size_array, bin = get_header bin

      parse_array([[], bin[...size_array]]) => [array, _]

      [array, bin[size_array..]]
    end

    private

    def header(budy)
      Dumper.code(Blejzer::UOArr) +
        [budy.size].pack('L')
    end

    def self.get_header(bin)
      code, bin = Dumper.header(1)[bin]
      size_array, * = bin.unpack('L')
      [code, size_array, bin[4..]]
    end

    def self.parse_array(xs)
      xs => [array, bin]

      return xs if bin.nil? or bin.empty?

      code, = Dumper.header(1)[bin]
      # TODO: Check for incorrect data and blah, blah, blah.
      Blejzer::T.find_by_code(code).impl.load(bin) => [value, bin]

      parse_array([array << value, bin])
    rescue StandardError
      raise Blejzer::Error, 'Incorrect binary format!'
    end
  end
end

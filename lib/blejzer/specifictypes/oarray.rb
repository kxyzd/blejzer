# frozen_string_literal: true

module Blejzer
  class OptimizedArray
    def initialize(array)
      @array = array
      specific_types =
        array.map(&Dumper.method(:what_is_the_specific_type))

      @values = @array.zip(specific_types)
                      .map { |(val, type)| type.new(val) }

      @type, *types = @values.map(&:metatype)

      raise 'unoptimized array' \
        unless types.all? @type
    end

    def dump
      body = @values.map do
        Dumper.header(1)[_1.dump].last
      end.join

      header(body) + body
    end

    def self.load(bin)
      _, metatype, bin = Dumper.header(2)[bin]
      size_array, bin = SpecificInteger.load(bin)

      parse_array([[], bin[...size_array]], metatype) => [value, _]

      [value, bin[size_array..]]
    end

    def self.is_optimized_array?(array)
      type, *types = array
                     .map(&Dumper.method(:what_is_the_specific_type))
                     .zip(array)
                     .map { |(type, val)| type.new(val) }
                     .map(&:metatype)

      types.all? type
    end

    def metatype
      OArr
    end

    private

    def self.parse_array(xs, metatype)
      xs => [array, bin]

      return xs if bin.nil? or bin.empty?

      # TODO: Check for incorrect data and blah, blah, blah.
      Blejzer::T.find_by_code(metatype)
                .impl
                .load(
                  # TODO: rewrite
                  [metatype].pack('C') + bin
                  # ^^^^^^^^^^^^^^^^^^
                  #       пиздец
                ) => [value, bin]

      parse_array([array << value, bin], metatype)
    rescue StandardError
      raise Blejzer::Error, 'Incorrect binary format!'
    end

    def header(body)
      Dumper.code(OArr) +
        Dumper.code(@type) +
        Blejzer(body.size)
    end
  end
end

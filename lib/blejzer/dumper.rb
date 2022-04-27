# frozen_string_literal: true

module Blejzer
  module Dumper
    class << self
      def Blejzer(obj)
        case obj
        when String
          code, = header(1)[obj]
          T.find_by_code(code)
           .impl
           .load(obj)
           .first
        else
          what_is_the_specific_type(obj)
            .new(obj)
            .dump
        end
      end

      def code(type)
        raise TypeError unless type.is_a? Blejzer::Type

        [type.code].pack('C')
      end

      def what_is_the_specific_type(object)
        case object
        when Integer
          SpecificInteger
        when Array
          UOArray
        when ->(obj) { obj.respond_to? :members }
          SpecificStruct
        when String
          SpecificString
        else
          raise "unsupport(#{object.inspect})"
        end
      end

      def header(n)
        lambda do |bin|
          codes = bin[...n].bytes
          [*codes, bin[n..]]
        end
      end

      def unpack(bin, directive)
        bin.unpack1(directive)
      end
    end
  end
end

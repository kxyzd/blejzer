# frozen_string_literal: true

module Blejzer
  # Вспомогательный модуль для объединения абстрактного
  # функционала над сериализации.
  module Dumper
    class << self
      # @param obj [String, Object]
      # @example
      #   Dumper.Blejzer(bin) #=> 389
      # @return [String, Object]
      def Blejzer(obj)
        case obj
        when String
          code, bin = header(1)[obj]
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

      # Кодирует метаинформацию в байт-типа.
      # @param type [Type]
      # @return String
      def code(type)
        raise TypeError unless type.is_a? Blejzer::Type

        [type.code].pack('C')
      end

      # Метод для определения типа переданного объекта,
      # то есть нахождения подходящего специального типа. 
      # @return [SpecificType]
      def what_is_the_specific_type(object)
        # TODO: Переписать более декларативно. Много строк!
        case object
        when Integer
          if SpecificBigNumber::RANGE.include? object
            SpecificBigNumber
          else
            SpecificInteger
          end
        when Array
          CommonArray
        when ->(obj) { obj.respond_to? :members }
          SpecificStruct
        when String
          SpecificString
        when NilClass
          SpecificNil
        when TrueClass, FalseClass
          SpecificBool
        else
          # TODO: Сделать нормальный вывод ошибок!
          raise "unsupport(#{object.inspect})"
        end
      end

      # Метод для получения первых байтов метаинформации.
      # @param n [Integer] Кол-во байтов.
      # @example
      #   code, bin = Dumper.header(1)[bin]
      # @return [Proc[Integer, ..., String]]
      def header(n)
        lambda do |bin|
          codes = bin[...n].bytes
          [*codes, bin[n..]]
        end
      end

      # @deprecated
      def unpack(bin, directive)
        bin.unpack1(directive)
      end
    end
  end
end

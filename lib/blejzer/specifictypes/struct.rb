# frozen_string_literal: true

module Blejzer
  Any = :any

  refine Class do
    def from(bin)
      new(*Blejzer::Dumper.Blejzer(bin))
    end

    def type(*types)
      lambda do |value|
        new(*value.zip(types).map do |(val, type)|
          case type
          in Any
            val
          in Proc
            type[val]
          in Class
            type.new(*val)
          end
        end)
      end
    end

    def typed(*types)
      lambda do |bin|
        new(*Blejzer::Dumper.Blejzer(bin).zip(types).map do |(val, type)|
          case type
          in Any
            val
          in Proc
            type[val]
          in Class
            type.new(*val)
          end
        end)
      end
    end
  end

  class SpecificStruct
    def initialize(object)
      members = object.members
      values =  members.map { object.send(_1) }

      @array = UOArray.new(values)
    end

    def dump
      @array.dump
    end

    def self.load(bin)
      UOArray.load(bin)
    end
  end
end

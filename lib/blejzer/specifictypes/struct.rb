# frozen_string_literal: true

module Blejzer
  Any = :any
  Self = :self
  Auto = Any

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

    def metatype
      UOArr
    end
  end
end

class Class
  def from(bin)
    new(*Blejzer::Dumper.Blejzer(bin))
  end

  def type(*types)
    lambda do |value|
      new(*value.zip(types).map do |(val, type)|
        case type
        when Blejzer::Any
          val
        when Proc
          type[val]
        when Class
          type.new(*val)
        end
      end)
    rescue StandardError
      raise Blejzer::Error, 'Failed to deserialize by pattern.'
    end
  end

  def typed(*types)
    lambda do |bin|
      new(*Blejzer::Dumper.Blejzer(bin).zip(types).map do |(val, type)|
        case type
        when Blejzer::Any
          val
        when Proc
          type[val]
        when Class
          type.new(*val)
        end
      end)
    rescue StandardError
      raise Blejzer::Error, 'Failed to deserialize by pattern.'
    end
  end
end

class Module
  # A modifier specifying which fields should be serialized.
  def members(*names)
    for name in names
      next if instance_methods(false).include? name

      raise Blejzer::Error,
            "Instance variable `#{name}` must be readable!"
    end

    define_method(:members) { names }
  end
end

# frozen_string_literal: true

module Blejzer
  class CommonArray
    def initialize(array)
      @klass = if OptimizedArray.is_optimized_array? array
                 OptimizedArray
               else
                 UOArray
               end.new(array)
    end

    def dump
      @klass.dump
    end

    def self.load(bin)
      code, = Dumper.header(1)[bin]

      case code
      when UOArr.code
        UOArray.load(bin)
      when OArr.code
        OptimizedArray.load(bin)
      else
        # TODO: *_*
        raise 'aaaa'
      end
    end

    def metatype
      nil
    end
  end
end

# frozen_string_literal: true

require_relative 'blejzer/version'

require_relative 'blejzer/types'

require_relative 'blejzer/dumper'
# require_relative 'blejzer/specifictypes/number'
# require_relative 'blejzer/specifictypes/uoarr'
# require_relative 'blejzer/specifictypes/struct'
# require_relative 'blejzer/specifictypes/string'
# require_relative 'blejzer/specifictypes/null'
# require_relative 'blejzer/specifictypes/bool'

# A module for simple and compact serialization
# of Ruby objects into binary format.
module Blejzer
  # Используемый бинарный формат очень простой.
  # Сначала идёт байт мета-информации, сообщающий об типе данных,
  # после чего идут опциональные поля(для массива это, например,
  # его размер), а далее уже сами данные.
  #
  #                      байт данных
  #                         vvvv
  #     Bejzer(234) => "\x01\xEA"
  #                     ^^^^
  #                   байт-типа
  #
  # При сериализации блейзер сам определяет оптимальный тип для данных.
  # Так, например, для значения 240 будет оптимальный тип UByte
  # (беззнаковый байт).

  class Error < StandardError; end
end

# Метод для сериализации и десериализации.
# При передачи строки происходит десериализация,
# а при передаче другого объект сериализация.
# @param object [String, Object]
# @return [String, Object]
def Blejzer(object)
  Blejzer::Dumper.Blejzer(object)
end

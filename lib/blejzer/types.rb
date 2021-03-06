# frozen_string_literal: true

require_relative 'specifictypes/number'
require_relative 'specifictypes/uoarr'
require_relative 'specifictypes/struct'
require_relative 'specifictypes/string'
require_relative 'specifictypes/null'
require_relative 'specifictypes/bool'
require_relative 'specifictypes/bignumber'
require_relative 'specifictypes/commonarray'
require_relative 'specifictypes/oarray'

module Blejzer
  # Класс для представления метаинформации
  # о типе: его коде и классе, который его реализует.
  # @attr code [Integer] Код байта-типа.
  # @attr impl [SpecificType] Класс, который реализует данный тип.
  Type = Struct.new(:code, :impl)

  # Общий интерфейс для всех специальных типов.
  class SpecificType
    # @return [String]
    def dump; end

    # @param bin [String]
    # @return [[Object, String]]
    def self.load(bin); end
  end

  # Список всех поддерживаемых типов.
  T = [
    UByte  = Type.new(1, SpecificInteger),
    UShort = Type.new(2, SpecificInteger),
    UInt   = Type.new(3, SpecificInteger),
    ULong  = Type.new(4, SpecificInteger),

    Byte   = Type.new(5, SpecificInteger),
    Short  = Type.new(6, SpecificInteger),
    Int    = Type.new(7, SpecificInteger),
    Long   = Type.new(8, SpecificInteger),

    BigNumber = Type.new(10, SpecificBigNumber),

    UOArr = Type.new(50, UOArray),
    OArr = Type.new(51, OptimizedArray),

    CStr   = Type.new(70, SpecificString),

    Null   = Type.new(80, SpecificNil),

    BTrue  = Type.new(81, SpecificBool),
    BFalse = Type.new(82, SpecificBool)
  ]

  # Список описания критерий типов для чисел.
  TNumber = [
    [0..255, UByte, 'C', 1],
    [0..65_535, UShort, 'S', 2],
    [0..4_294_967_295, UInt, 'L', 4],
    [0..18_446_744_073_709_551_615, ULong, 'Q', 8],

    [-127..126, Byte, 'c', 1],
    [-32_768..32_767, Short, 's', 2],
    [-2_147_483_648..2_147_483_647, Int, 'l', 4],
    [
      -9_223_372_036_854_775_808..9_223_372_036_854_775_807,
      Long, 'q', 8
    ],
    [SpecificBigNumber::RANGE, BigNumber]
  ]

  # @param code [Integer]
  # @return [Type]
  def T.find_by_code(code)
    find { _1.code == code }
  end

  T.freeze
end

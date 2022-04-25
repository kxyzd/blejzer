# frozen_string_literal: true

require_relative 'specifictypes/number'

module Blejzer
  Type = Struct.new(:code, :impl)

  T = [
    Byte = Type.new(10, SpecificInteger),
    Int  = Type.new(30, SpecificInteger)
  ]

  TNumber = [
    [-127..126, Byte, 'c'],
    [-2_147_483_648..2_147_483_647, Int, 'l']
  ]

  def T.find_by_code(code)
    find { _1.code == code }
  end
end

# frozen_string_literal: true

require_relative 'specifictypes/number'
require_relative 'specifictypes/uoarr'
require_relative 'specifictypes/struct'
require_relative 'specifictypes/string'

module Blejzer
  Type = Struct.new(:code, :impl)

  T = [
    Byte  = Type.new(10, SpecificInteger),
    Int   = Type.new(30, SpecificInteger),

    UOArr = Type.new(50, UOArray),

    CStr  = Type.new(70, SpecificString)
  ]

  TNumber = [
    [-127..126, Byte, 'c', 1],
    [-2_147_483_648..2_147_483_647, Int, 'l', 4]
  ]

  def T.find_by_code(code)
    find { _1.code == code }
  end
end

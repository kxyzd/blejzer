require 'rspec'
require_relative '../lib/blejzer'

describe Blejzer::SpecificStruct do
  it 'serialization of struct' do
    Point = Struct.new(:x, :y)
    Rect  = Struct.new(:point, :size)

    source_rect = Rect.new(
      Point.new(-21_328, -2),
      987_843
    )

    blejzered_rect = Blejzer source_rect

    expect(
      Rect.typed(
        Point,
        Blejzer::Auto
      )[blejzered_rect]
    ).to eq(source_rect)
  end
end

require 'rspec'
require_relative '../lib/blejzer'

describe Blejzer::UOArray do
  it 'serialization of UOArray' do
    source_array = [
      1, 'hi', false, [true, nil],
      Struct.new(:x, :y).new(90, -23)
    ]

    blejzered_array = Blejzer source_array

    expect(
      Blejzer(blejzered_array)
    ).to eq(source_array[...-1] << [90, -23])
  end
end

require 'rspec'
require_relative '../lib/blejzer'

describe Blejzer::SpecificString do
  it 'serialization of string' do
    source_string = 'съешь ещё этих мягких французских булок, да выпей чаю'
    blejzered_string = Blejzer [source_string]
    expect(
      Blejzer(blejzered_string)
    ).to eq([source_string])
  end
end

require 'rspec'
require_relative '../lib/blejzer'

describe Blejzer::SpecificInteger do
  it 'serialization of integers' do
    1000.times.lazy.map { rand(10_000_000) }.each do |num|
      blejzered_number = Blejzer Blejzer num
      expect(blejzered_number).to eq(num)
    end
  end
end

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

describe Blejzer::SpecificBigNumber do
  it 'serialization of bignumber' do
    source_number =
      43_563_221_839_684_273_864_356_734_638_749_743_934_563_482_973_643
    blejzered_number = Blejzer source_number

    expect(Blejzer(blejzered_number))
      .to eq(source_number)
  end
end

require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }

  it 'should have a default balance of 0' do
    expect(oyster.balance).to eq 0
  end

  describe '#top_up' do

    it 'should allow user to add money to oystercard' do
      oyster.top_up(5)
      expect(oyster.balance).to eq 5
    end

    it 'should raise error if over limit' do
      oyster.top_up(oyster.maximum)
      expect { oyster.top_up(1) }.to raise_error "balance cannot exceed £#{oyster.maximum}"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'should deduct money from oystercard' do
      oyster.top_up(10)
      oyster.deduct(5)
      expect(oyster.balance).to eq 5
    end
  end
end

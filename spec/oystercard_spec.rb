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

  describe '#touch_in' do
    before { oyster.top_up(Oystercard::MAXIMUM_BALANCE) }

    it 'should initial not be in a journey' do
      expect(oyster).not_to be_in_journey
    end

    it 'should change journey status to true' do
      oyster.touch_in
      expect(oyster).to be_in_journey
    end

    it "should raise error if card doesn't have minimum fare" do
      expect { subject.touch_in }.to raise_error 'Insufficient balance to touch in'
    end
  end

  describe '#touch_out' do
    before { oyster.top_up(Oystercard::MAXIMUM_BALANCE) }

    it 'should initial be in a journey' do
      oyster.touch_in
      expect(oyster).to be_in_journey
    end

    it 'should change journey status to false' do
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end

    it 'should charge the minimum amount' do
      expect {oyster.touch_out}.to change{oyster.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end
  end
end

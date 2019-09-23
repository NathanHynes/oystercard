require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }

  it "should have a default balance of 0" do
    expect(oyster.balance).to eq 0
  end

  describe '#top_up' do
    it "should allow user to add money to oystercard" do
      oyster.top_up(5)
      expect(oyster.balance).to eq 5
    end

    it "should raise error if over limit" do
      expect { oyster.top_up(91) }.to raise_error "balance cannot exceed £#{oyster.maximum}"
    end
  end


end

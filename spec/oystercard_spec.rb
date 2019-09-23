require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }

  it "should have a default balance of 0" do
    expect(oyster.balance).to eq 0
  end

end

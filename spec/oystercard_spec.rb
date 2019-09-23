require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }

  it "should have a default balance of 0" do
    expect(oyster.balance).to eq 0
  end

  it "should allow user to add money to oystercard" do
    expect (oyster.top_up(5).balance).to eq 5
  end

end

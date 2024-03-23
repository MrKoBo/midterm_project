require_relative 'spec_helper'
require 'midterm_project'

RSpec.describe Card do
  let(:card) { Card.new("Ten", "Spades") }

  describe "#display" do
    it "tells the user which card it is" do
      expect { card.display }.to output("Ten of Spades\n").to_stdout
    end
  end
end

RSpec.describe Deck do
  describe "#shuffle_deck" do
    it "shuffles the current deck" do
      new_deck = Deck.new
      shuffeled_deck = new_deck.shuffle_deck
      expect(shuffeled_deck).not_to be (new_deck)
    end
  end
  describe "#deal" do
    it "returns top card" do
      new_deck = Deck.new
      first_card = new_deck.active_deck[0]
      card_dealt = new_deck.deal
      expect(card_dealt).to eq(first_card)
    end

    it "top card is removed" do
      new_deck = Deck.new
      card_dealt = new_deck.deal
      expect(new_deck.active_deck.length).to eq(51)
    end
  end



end

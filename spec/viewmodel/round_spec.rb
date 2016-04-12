require 'rails_helper'

RSpec.describe CardStack, type: :class do
  let(:num_players) { 4 }
  let(:round) { Round.new(num_players) }

  describe 'Initialize' do
    it 'has one card on the discard pile' do
      expect(round.discard.length).to eq 1
    end

    it 'has correct number of cards for each hand' do
      expect(round.player_hands[0].length).to eq 7
      expect(round.player_hands[1].length).to eq 7
      expect(round.player_hands[2].length).to eq 7
      expect(round.player_hands[3].length).to eq 7
    end

    it 'has correct cards left in pickup pile' do
      expect(round.pickup.length).to eq (54 - (num_players * 7) - round.discard.length)
    end
  end
end

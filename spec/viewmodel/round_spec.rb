require 'rails_helper'

RSpec.describe Round, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:num_players) { 4 }
  let(:round) { Round.new(num_players) }

  describe 'Initialize' do
    it 'has one card on the discard pile' do
      expect(round.discard.length).to eq 1
    end

    it 'has correct number of cards for each hand' do
      expect(round.players[0].hand.length).to eq 7
      expect(round.players[1].hand.length).to eq 7
      expect(round.players[2].hand.length).to eq 7
      expect(round.players[3].hand.length).to eq 7
    end

    it 'has correct cards left in pickup pile' do
      expect(round.pickup.length).to eq (54 - (num_players * 7) - round.discard.length)
    end

    it 'has the expected meld stacks' do
      expect(round.melds.find(suite: 'C')).to be_truthy
      expect(round.melds.find(rank: 'A')).to be_truthy
      expect(round.melds.find(rank: '5')).to be_truthy
      expect(round.melds.find(rank: 'K')).to be_truthy
    end

    it 'can find a rank meld' do
      expect(round.find_meld(cards_from_values(%w(H3 C3 H3))).rank).to eq 3
    end

    it 'can find a suite meld' do
      expect(round.find_meld(cards_from_values(%w(H3 H4 H5))).suite).to eq 'H'
    end

    it 'cannot find an inconsecutive meld' do
      expect(round.find_meld(cards_from_values(%w(H3 H4 C7)))).to be_nil
    end
  end
end

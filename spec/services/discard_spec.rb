require 'rails_helper'

RSpec.describe Discard, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { %w(D3 S4 H4 D4 C4) }
  let(:card) { 'H4' }
  let(:round) do
    round = Round.new(4)

    cards.each { |val| round.current_player.hand << round.steal_card(id: val) }

    round
  end

  let!(:result) { Discard.new(round: round, player: round.current_player, card_id: card).call }

  context 'user discards an owned card' do
    it 'Returns true' do
      expect(result).to be_truthy
    end

    it 'Removed the card from the players hand' do
      expect(round.current_player.hand.to_ids).to eq %w(D3 S4 D4 C4)
    end

    it 'Added the card to the discard pile' do
      expect(round.discard.to_ids).to eq %w(H4)
    end
  end
end

require 'rails_helper'

RSpec.describe DrawDiscarded, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { %w(D3 S4 H4 D4 C4) }
  let(:stack) { CardStack.new(cards: cards) }
  let(:round) do
    round = Round.new(4)

    cards.each { |val| round.discard << round.steal_card(id: val) }

    round.deal
  end

  before do
    DrawDiscarded.new(round: round, player: player, card: from).call
  end

  let(:player) { round.players[0] }
  let(:from) { 'H4' }
  let(:result) { player.hand.cards.map{ |card| card.id } }
  let(:discard_stack_cards) { round.discard.cards.map{ |card| card.id } }

  context 'Sweep from middle' do
    let(:from) { 'H4' }

    it 'gets everything from the middle onwards' do
      expect(result).to have_all %w(H4 D4 C4)
    end

    it 'removes taken cards' do
      expect(discard_stack_cards).to have_none %w(H4 D4 C4)
    end

    it 'leaves unwanted cards' do
      expect(discard_stack_cards).to have_all %w(D3 S4)
    end
  end
end

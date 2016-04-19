require 'rails_helper'

RSpec.describe Draw, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { %w(D3 S4 H4 D4 C4) }
  let(:card) { 'joker2' }
  let(:round) { Round.new(4) }
  let(:pickup_size) { round.pickup.cards.length }
  let!(:result) { Draw.new(round.current_player, round).call }

  context 'user discards an owned card' do
    it 'Returns true' do
      expect(result).to be_truthy
    end

    it 'Removed card from the pickup pile' do
      expect(round.pickup.to_ids).to have_none [card]
    end

    it 'Added card to players hand' do
      expect(round.current_player.hand.to_ids).to have_all [card]
    end

    it 'Still have the rest of the cards on the pickup pile' do
      expect(pickup_size).to eq 53
    end
  end
end

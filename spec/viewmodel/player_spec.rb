require 'rails_helper'

RSpec.describe Player, type: :class do
  let(:round) { Round.new(4) }
  let(:player) { round.current_player_turn }

  it 'references its parent round' do
    round.players.each { |player| expect(player.round).to be round }
  end

  it "has won if it doesn't have cards" do
    expect(player).to be_won
  end

  it 'has not won if it has cards' do
    player.hand << round.steal_card(id: 'H4')
    expect(player).not_to be_won
  end

  context 'has a meld' do
    let(:card_ids_to_meld) { %w(H2 H3 H4) }
    let(:cards_to_meld) { round.find_cards_by_id(card_ids_to_meld) }
    let(:meld) { round.find_meld(cards_to_meld) }

    before do
      %w(H2 H3 H4 D2 D3).each{|card| player.hand << round.steal_card(id: card)}
      Meld.new(round: round, player: player, cards: cards_to_meld).call
    end

    it 'which is part of players list of melds' do
      expect(player.melds[0]).to be meld
    end
  end
end

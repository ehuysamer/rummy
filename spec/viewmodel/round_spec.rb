require 'rails_helper'

RSpec.describe Round, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:num_players) { 4 }
  let(:round) { Round.new(num_players).deal }

  describe '.Initialize' do
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
  end

  describe '.find_meld' do
    it 'can find a rank meld' do
      expect(round.find_meld(cards_from_ids(%w(H3 C3 H3))).rank).to eq 3
    end

    it 'can find a suite meld' do
      expect(round.find_meld(cards_from_ids(%w(H3 H4 H5))).suite).to eq 'H'
    end

    it 'cannot find an inconsecutive meld' do
      expect(round.find_meld(cards_from_ids(%w(H3 H4 C7)))).to be_nil
    end
  end

  describe '.next_player' do
    it 'advances to the next player' do
      expect(round.next_player).to be round.players[1]
    end

    it 'changes the current player' do
      result = round.next_player
      expect(round.current_player).to be result
    end

    it 'wraps after the last player' do
      num_players.times { round.next_player }
      expect(round.current_player).to be round.players[0]
    end
  end

  context 'in the "find" scenario' do
    let(:discard) { round.discard }

    let!(:meld_cards) { [round.steal_card(suite: 'H', rank: 8),
                        round.steal_card(suite: 'H', rank: 9),
                        round.steal_card(suite: 'H', rank: 10)] }

    let(:meld) { round.find_meld(meld_cards) }
    let(:player) { round.players[0].hand }
    let(:pickup) { round.pickup }

    before do
      pickup << round.steal_card(suite: 'H', rank: 2)
      discard << round.steal_card(suite: 'H', rank: 5)
      meld.concat(meld_cards)
      player << round.steal_card(suite: 'H', rank: 1)
    end

    describe '.find_card' do
      it 'finds the card in the pickup stack' do
        expect(round.find_card(suite: 'H', rank: 2).id).to eq 'H2'
      end

      it 'finds the card in the discard stack' do
        expect(round.find_card(suite: 'H', rank: 5).id).to eq 'H5'
      end

      it 'finds the card in the meld stack' do
        expect(round.find_card(suite: 'H', rank: 8).id).to eq 'H8'
      end

      it 'finds the card in the players hand' do
        expect(round.find_card(suite: 'H', rank: 1).id).to eq 'HA'
      end
    end

    describe '.replace_card' do
      let(:card) { round.steal_card(suite: 'D', rank: '4') }

      it 'finds the card in the pickup stack' do
        round.replace_card(suite: 'H', rank: 2, replace_with_card: card)
        expect(pickup.find(suite: 'H', rank: 2)).to be_nil
      end

      it 'finds the card in the discard stack' do
        round.replace_card(suite: 'H', rank: 5, replace_with_card: card)
        expect(discard.find(suite: 'H', rank: 5)).to be_nil
      end

      it 'finds the card in the meld stack' do
        round.replace_card(suite: 'H', rank: 8, replace_with_card: card)
        expect(meld.find(suite: 'H', rank: 8)).to be_nil
      end

      it 'finds the card in the players hand' do
        round.replace_card(suite: 'H', rank: 1, replace_with_card: card)
        expect(player.find(suite: 'H', rank: 1)).to be_nil
      end
    end

    describe '.steal_card' do
      it 'finds the card in the pickup stack' do
        round.steal_card(suite: 'H', rank: 2)
        expect(pickup.find(suite: 'H', rank: 2)).to be_nil
      end

      it 'finds the card in the discard stack' do
        round.steal_card(suite: 'H', rank: 5)
        expect(discard.find(suite: 'H', rank: 5)).to be_nil
      end

      it 'finds the card in the meld stack' do
        round.steal_card(suite: 'H', rank: 8)
        expect(meld.find(suite: 'H', rank: 8)).to be_nil
      end

      it 'finds the card in the players hand' do
        round.steal_card(suite: 'H', rank: 1)
        expect(player.find(suite: 'H', rank: 1)).to be_nil
      end
    end

    describe '.find_stack' do
      it 'finds the card in the pickup stack' do
        expect(round.find_stack(suite: 'H', rank: 2)).to eq pickup
      end

      it 'finds the card in the discard stack' do
        expect(round.find_stack(suite: 'H', rank: 5)).to eq discard
      end

      it 'finds the card in the meld stack' do
        expect(round.find_stack(suite: 'H', rank: 8)).to eq meld
      end

      it 'finds the card in the players hand' do
        expect(round.find_stack(suite: 'H', rank: 1)).to eq player
      end
    end
  end
end

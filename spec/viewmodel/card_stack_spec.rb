require 'rails_helper'

RSpec.describe CardStack, type: :class do
  #include ApplicationHelper

  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { [] }
  let(:stack) { CardStack.new(cards: cards) }

  describe 'Initialize' do
    it 'empty' do
      expect(CardStack.new.cards.length).to eq 0
    end
  end

  describe 'Add all' do
    let(:cards) { [] }

    before { stack.add_all }

    it 'to have everything' do
      expect(stack.cards.length).to eq 54
    end
  end

  describe 'Push' do
    let(:cards) { cards_2 }

    it 'has two cards' do
      expect(stack.cards.length).to eq 2
    end

    it 'has cards in correct order' do
      expect(stack.cards.map{ |card| card.id }).to eq %w(H2 C3)
    end
  end

  describe 'Pop' do
    let(:cards) { cards_2 }

    it 'pops the last card first' do
      expect(stack.pop.id).to eq 'C3'
    end

    it 'pops the first card next' do
      stack.pop
      expect(stack.pop.id).to eq 'H2'
    end
  end

  describe 'sweep_from' do
    let(:cards) { cards_variety }
    let(:card) { 'H8' }
    let!(:taken) { stack.sweep_from(card).map{|c|c.id} }
    let(:remaining) { stack.cards.map{|c|c.id} }

    context 'sweep from beginning' do
      let(:card) { 'H8' }

      it 'gets all the cards' do
        expect(taken).to eq cards_variety.map{|c|c.id}
      end

      it 'does not leave cards behind' do
        expect(remaining).to be_empty
      end
    end

    context 'sweep last card' do
      let(:card) { 'H9' }

      it 'gets the card' do
        expect(taken).to eq %w(H9)
      end

      it 'does not leave card behind' do
        expect(remaining).not_to include 'H9'
      end

      it 'leaves all others behind' do
        expect(remaining).to eq %w(H8 HA H10 HJ HQ HK J JD2)
      end
    end

    #%w(H8 HA H10 HJ HQ HK J JD2 H9)

    context 'sweep an unranked joker' do
      let(:card) { 'J' }

      it 'gets the cards' do
        expect(taken).to eq %w(J JD2 H9)
      end

      it 'does not leave them behind' do
        expect(remaining).to have_none %w(J JD2 H9)
      end

      it 'leaves others behind' do
        expect(remaining).to eq %w(H8 HA H10 HJ HQ HK)
      end
    end

    context 'sweep a ranked joker' do
      let(:card) { 'JD2' }

      it 'gets the cards' do
        expect(taken).to eq %w(JD2 H9)
      end

      it 'does not leave them behind' do
        expect(remaining).to have_none %w(JD2 H9)
      end

      it 'leaves others behind' do
        expect(remaining).to eq %w(H8 HA H10 HJ HQ HK J)
      end
    end
  end

  describe 'Shuffle' do
    let(:cards) { cards_5_with_joker }

    before do
      stack.shuffle
    end

    it 'still has 5 cards' do
      expect(stack.cards.length).to eq 5
    end

    it 'still has each card cards' do
      expect(stack.cards.map{ |card| card.id }).to include 'H2'
      expect(stack.cards.map{ |card| card.id }).to include 'C3'
      expect(stack.cards.map{ |card| card.id }).to include 'S4'
      expect(stack.cards.map{ |card| card.id }).to include 'D5'
      expect(stack.cards.map{ |card| card.id }).to include 'J'
    end

    it 'has a different order' do
      expect(stack.cards.map{ |card| card.id }).not_to eq %w(H2 C3 S4 D5 JOKER)
    end
  end

  describe 'Find' do
    let(:cards) { cards_5_with_joker }

    it 'can find a contained card by id' do
      expect(stack.find(id: 'J').id).to eq 'J'
    end

    it 'can find a contained card by rank and suite' do
      #TODO: Must confirm everywhere that rank is an integer
      expect(stack.find(suite: 'C', rank: 3).id).to eq 'C3'
    end

    it 'returns nil if a card could not be found' do
      expect(stack.find(suite: 'H', rank: 'A')).to be_nil
    end
  end

  describe 'Remove by id' do
    let(:cards) { cards_5_with_joker }

    it 'returns the card that was removed' do
      expect(stack.remove_by_id(id: 'H2').id).to eq 'H2'
    end

    it 'removes the card' do
      stack.remove_by_id(id: 'H2')
      expect(stack.cards.map{ |card| card.id }).not_to include 'H2'
    end

    it 'only removes one card' do
      stack.remove_by_id(id: 'H2')
      expect(stack.length).to eq 4
    end
  end

  describe 'Sweep the stack' do
    let(:cards) { cards_5_with_joker }
    let!(:returned) { stack.sweep_from('S4') }

    it 'returns last 3 cards' do
      expect(returned.map {|card| card.id }).to eq ['S4', 'D5', 'J']
    end

    it 'keep first 2 cards' do
      expect(stack.cards.map {|card| card.id }).to eq ['H2', 'C3']
    end
  end

  describe 'Pick' do
    let(:cards) { cards_5_with_joker }
    let(:picks) { ['C3', 'S4', 'D5'] }

    it 'can pick 3 cards' do
      expect(stack.pick(picks).map{|card| card.id}).to eq picks
    end

    it 'leaves cards behind' do
      stack.pick(picks)
      expect(stack.cards.map{|card| card.id}).to eq ['H2', 'J']
    end
  end

  #TODO: Card owner
  #TODO: Card sort
  #TODO: common context: lower, higher, etc. stacks from line 192

  #TODO: Move this to correct spec file
  describe 'cards_from_ids' do
    it 'Converts numbered ranks correctly' do
      expect(cards_from_ids(%w(H2 H3 H4 H5 H6 H7 H8 H9)).map{ |card| card.rank }).to eq [2, 3, 4, 5, 6, 7, 8, 9]
    end

    it 'Converts numbered ranks with jokers correctly' do
      expect(cards_from_ids(%w(JH2 JH3 JH4 JH5 JH6 JH7 JH8 JH9)).map{ |card| card.rank }).to eq [2, 3, 4, 5, 6, 7, 8, 9]
    end

    it 'Converts symbols correctly' do
      expect(cards_from_ids(%w(HJ HQ HK HA)).map{ |card| card.rank }).to eq [11, 12, 13, 1]
    end

    it 'Converts 10 correctly' do
      expect(cards_from_ids(%w(H10 JH10)).map{ |card| card.rank }).to eq [10, 10]
    end
  end

  describe 'is adjacent' do
    let(:result) { CardStack.is_adjacent(source, target) }

    context 'adjacent cards' do
      let(:source) { Card.new(suite: 'H', rank: 4, id: 'H4') }
      let(:target) { Card.new(suite: 'H', rank: 5, id: 'H5') }

      it 'are adjacent' do
        expect(result).to be_truthy
      end
    end

    context 'non-adjacent cards' do
      let(:source) { Card.new(suite: 'H', rank: 4, id: 'H4') }
      let(:target) { Card.new(suite: 'H', rank: 2, id: 'H2') }

      it 'are non adjacent' do
        expect(result).to be_falsey
      end
    end

    context 'higher wrap cards' do
      let(:source) { Card.new(suite: 'H', rank: 1, id: 'HA') }
      let(:target) { Card.new(suite: 'H', rank: 13, id: 'HK') }

      it 'are adjacent' do
        expect(result).to be_truthy
      end
    end

    context 'lower wrap cards' do
      let(:source) { Card.new(suite: 'H', rank: 13, id: 'HK') }
      let(:target) { Card.new(suite: 'H', rank: 1, id: 'HA') }

      it 'are adjacent' do
        expect(result).to be_truthy
      end
    end
  end

  describe 'move_any_adjacent_card' do
    let!(:result) { CardStack.move_any_adjacent_card(source, target) }

    context 'empty list' do
      let(:source) { cards_from_ids(%w(H3)) }
      let(:target) {[]}

      it 'moved card to target' do
        expect(target.map{|card| card.id}).to include 'H3'
      end

      it 'removed card from source' do
        expect(source.map{|card| card.id}).not_to include 'H3'
      end

      it 'returns card that got moved' do
        expect(result.id).to eq 'H3'
      end
    end

    context 'one card on each side' do
      let(:source) { cards_from_ids(%w(H3)) }
      let(:target) { cards_from_ids(%w(H4)) }

      it 'moved card to target' do
        expect(target.map{|card| card.id}).to include 'H3'
      end

      it 'others on target is still there' do
        expect(target.map{|card| card.id}).to include 'H4'
      end

      it 'removed card from source' do
        expect(source.map{|card| card.id}).not_to include 'H3'
      end

      it 'returns card that got moved' do
        expect(result.id).to eq 'H3'
      end
    end

    context 'wrap onto higher stack' do
      let(:source) { cards_from_ids(%w(HA)) }
      let(:target) { cards_from_ids(%w(HK)) }

      it 'moved card to target' do
        expect(target.map{|card| card.id}).to include 'HA'
      end

      it 'others on target is still there' do
        expect(target.map{|card| card.id}).to include 'HK'
      end

      it 'removed card from source' do
        expect(source.map{|card| card.id}).not_to include 'HA'
      end

      it 'returns card that got moved' do
        expect(result.id).to eq 'HA'
      end
    end

    context 'wrap onto lower stack' do
      let(:source) { cards_from_ids(%w(HK)) }
      let(:target) { cards_from_ids(%w(HA)) }

      it 'moved card to target' do
        expect(target.map{|card| card.id}).to include 'HK'
      end

      it 'others on target is still there' do
        expect(target.map{|card| card.id}).to include 'HA'
      end

      it 'removed card from source' do
        expect(source.map{|card| card.id}).not_to include 'HK'
      end

      it 'returns card that got moved' do
        expect(result.id).to eq 'HK'
      end
    end

    context 'nothing consecutive left' do
      let(:source) { cards_from_ids(%w(HA H2 H3)) }
      let(:target) { cards_from_ids(%w(H5 H6 H7)) }

      it 'does not move anything' do
        expect(target.map{|card| card.id}).to eq %w(H5 H6 H7)
      end

      it 'does not remove anything' do
        expect(source.map{|card| card.id}).to eq %w(HA H2 H3)
      end

      it 'returns falsey' do
        expect(result).to be_falsey
      end
    end
  end

  describe 'is_consecutive' do
    it 'is consecutive for low' do
      expect(CardStack.is_consecutive(cards_low)).to be_truthy
    end
    it 'is consecutive for mid' do
      expect(CardStack.is_consecutive(cards_mid)).to be_truthy
    end
    it 'is consecutive for high' do
      expect(CardStack.is_consecutive(cards_high)).to be_truthy
    end
    it 'is consecutive for wrap' do
      expect(CardStack.is_consecutive(cards_wrap)).to be_truthy
    end
    it 'is consecutive for full suite' do
      expect(CardStack.is_consecutive(cards_full_suite)).to be_truthy
    end
    it 'is inconsecutive for inconsecutive' do
      expect(CardStack.is_consecutive(cards_inconsecutive_ace)).to be_falsey
    end
  end

  describe 'can_meld' do
    context 'meld stack is for a rank' do
      let(:stack) { CardStack.new(rank: 4, cards: cards) }

      context 'has no cards in rank meld yet' do
        let(:cards) { cards_empty }

        it 'can start a rank meld with 3' do
          expect(stack.can_meld(cards_rank_meld_3)).to be_truthy
        end

        it 'cannot start a rank-meld less than 3' do
          expect(stack.can_meld(cards_rank_meld_incomplete)).to be_falsey
        end
      end

      context 'and has cards' do
        let(:cards) { cards_rank_meld_3 }

        it 'can meld another card' do
          expect(stack.can_meld(cards_from_ids %w(S4))).to be_truthy
        end

        it 'can meld a joker' do
          expect(stack.can_meld(cards_from_ids %w(JS4))).to be_truthy
        end

        it 'cannot meld another rank' do
          expect(stack.can_meld(cards_from_ids %w(C5))).to be_falsey
        end
      end

      # context 'has a rank stack with jokers' do
      #   let(:stack) do
      #     new_stack = CardStack.new(rank: 4)
      #     new_stack << Card.new(suite: 'H', rank: '4', value: 'H4')
      #     new_stack << Card.new(suite: 'C', rank: '4', value: 'joker')
      #     new_stack << Card.new(suite: 'D', rank: '4', value: 'joker2')
      #     new_stack
      #   end
      # end
    end

    context 'meld stack is for a suite' do
      let(:stack) { CardStack.new(suite: 'H', cards: cards) }

      context 'has no cards in suite meld yet' do
        let(:cards) { [] }

        it 'can start a suite meld with 3' do
          expect(stack.can_meld(cards_suite_meld_3)).to be_truthy
        end

        it 'cannot start a suite-meld less than 3' do
          expect(stack.can_meld(cards_suite_meld_incomplete)).to be_falsey
        end
      end

      context 'that has a mid stack' do
        let(:cards) { cards_mid }

        it 'and can meld above and below' do
          expect(stack.can_meld(cards_from_ids %w(H6 H10))).to be_truthy
        end

        it 'and cannot meld a different suite above' do
          expect(stack.can_meld(cards_from_ids %w(D10))).to be_falsey
        end

        it 'and cannot meld a different suite below' do
          expect(stack.can_meld(cards_from_ids %w(D6))).to be_falsey
        end

        it 'and cannot meld a card that is not consecutive' do
          expect(stack.can_meld(cards_from_ids %w(D5))).to be_falsey
        end
      end

      context 'has a low stack' do
        let(:cards) { cards_low }

        it 'and can meld above and below' do
          expect(stack.can_meld(cards_from_ids %w(HK H4))).to be_truthy
        end
      end

      context 'has a low stack with jokers' do
        let(:stack) do
          new_stack = CardStack.new
          new_stack << Card.new(suite: 'H', rank: 'A', id: 'joker', joker: true)
          new_stack << Card.new(suite: 'H', rank: '2', id: 'H2')
          new_stack << Card.new(suite: 'H', rank: '3', id: 'joker2', joker: true)
          new_stack
        end
      end

      context 'has a high stack' do
        let(:cards) { cards_high }

        it 'can meld above and below' do
          expect(stack.can_meld(cards_from_ids %w(H10 HA))).to be_truthy
        end
      end

      context 'has a high stack with jokers' do
        let(:stack) do
          new_stack = CardStack.new
          new_stack << Card.new(suite: 'H', rank: 'Q', id: 'joker', joker: true)
          new_stack << Card.new(suite: 'H', rank: 'K', id: 'HK')
          new_stack << Card.new(suite: 'H', rank: 'A', id: 'joker2', joker: true)
          new_stack
        end
      end

      context 'has a rollover stack' do
        let(:cards) { cards_wrap }

        it 'can meld above and below' do
          expect(stack.can_meld(cards_from_ids %w(HJ H3))).to be_truthy
        end
      end
    end
  end
end

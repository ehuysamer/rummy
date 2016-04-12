shared_context 'stack_samples' do
  let(:stack_5_with_joker) { CardStack.new(cards: cards_from_values('H2', 'C3', 'S4', 'D5', 'J')) }
  let(:stack_2) { CardStack.new(cards: cards_from_values('H2', 'C3')) }
  let(:stack_empty) { CardStack.new }
  let(:stack_meld_rank_4) { CardStack.new(rank: 4) }
  let(:stack_meld_suite_hearts) { CardStack.new(suite: 'H') }
end

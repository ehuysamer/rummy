shared_context 'stack_samples' do
  let(:cards_low) { construct 'HA', 'H2', 'H3' }

  let(:cards_5_with_joker) { cards_from_values('H2', 'C3', 'S4', 'D5', 'J') }
  let(:cards_2) { cards_from_values('H2', 'C3') }
  let(:cards_empty) { [] }

  let(:stack_meld_rank_4) { CardStack.new(rank: 4) }
  let(:stack_meld_suite_hearts) { CardStack.new(suite: 'H') }
end

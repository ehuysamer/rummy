shared_context 'stack_samples' do
  let(:cards_low) { cards_from_values %w(HA H2 H3) }
  let(:cards_high) { cards_from_values %w(HJ HQ HK) }
  let(:cards_mid) { cards_from_values %w(H7 H8 H9) }
  let(:cards_wrap) { cards_from_values %w(HQ HK HA H2) }
  let(:cards_inconsecutive_ace) { cards_from_values %w(HQ HK H2) }

  let(:cards_rank_meld_3) { cards_from_values %w(H4 JD4 JC4) }
  let(:cards_rank_meld_incomplete) { cards_from_values %w(H4 D4) }

  let(:cards_rank_meld_3) { cards_from_values %w(H4 JD4 JC4) }
  let(:cards_rank_meld_incomplete) { cards_from_values %w(H4 D4) }

  let(:cards_suite_meld_3) { cards_from_values %w(H4 JH5 JH6) }
  let(:cards_suite_meld_incomplete) { cards_from_values %w(H4 H5) }

  let(:cards_5_with_joker) { cards_from_values(%w(H2 C3 S4 D5 J)) }
  let(:cards_2) { cards_from_values(%w(H2 C3)) }
  let(:cards_empty) { [] }

  let(:stack_meld_rank_4) { CardStack.new(rank: 4) }
  let(:stack_meld_suite_hearts) { CardStack.new(suite: 'H') }
end

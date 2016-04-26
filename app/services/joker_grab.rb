class JokerGrab
  def initialize(round: nil, player: nil, card_submitted: nil, joker_id: nil)
    @round = round
    @player = player
    @card_submitted = card_submitted
    @joker_id = joker_id
  end

  def call
    hand = @player.hand

    card = hand.find(id: @card_submitted)
    return false unless card

    joker_stack = @round.find_stack(id: joker_id)
    return false unless joker_stack&.is_meld?

    joker_card = @round.find_card(id: joker_id)
    return false unless joker_card&.rank == card.rank && joker_card&.suite == card.suite

    card.chosen = false
    joker_card.chosen = false

    #TODO: stack.move_card(id, target_stack) / swap_card(id, target_stack, id2)

    hand.remove_cards([card])
    hand << @round.replace_card(id: joker_id, replace_with_card: card)

    joker_card.impersonate(suite: nil, rank: nil)

    true
  end

  private

  attr_reader :round, :player, :card_submitted, :joker_id
end

class JokerGrab
  def initialize(round: nil, player: nil, card_submitted: nil, joker_id: nil)
    @round = round
    @player = player
    @card_submitted = card_submitted
    @joker_id = joker_id
  end

  def call
    card = @player.hand.find(id: @card_submitted)
    return false unless card

    joker_stack = @round.find_stack(id: joker_id)
    return false unless joker_stack&.is_meld?

    joker_card = joker_stack.find(id: joker_id)
    return false unless joker_card&.rank == card.rank && joker_card&.suite == card.suite

    @player.hand.move_to(id: @card_submitted, stack: joker_stack)
    joker_stack.move_to(id: @joker_id, stack: @player.hand)

    card.chosen = false
    joker_card.chosen = false
    joker_card.impersonate(suite: nil, rank: nil)

    true
  end

  private

  attr_reader :round, :player, :card_submitted, :joker_id
end

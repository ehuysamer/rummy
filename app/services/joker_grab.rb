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
    if card.nil?
      return false
    end

    card.chosen = false
    hand.remove_cards([card])

    #TODO: Check that the joker is in a meld!

    joker_card = @round.find_card(id: joker_id)
    if joker_card.rank == card.rank && joker_card.suite == card.suite
      joker_card.chosen = false
      joker_card.rank = nil
      joker_card.suite = nil
      hand << @round.replace_card(id: joker_id, replace_with_card: card)
      return true
    end

    false
  end

  private

  attr_reader :round, :player, :card_submitted, :joker_id
end

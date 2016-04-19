class JokerGrab
  def initialize(round, player, card_submitted)
    @round = round
    @player = player
    @card_submitted = card_submitted
  end

  def call
    hand = @player.hand
    card = hand.find(value: @card_submitted)
    card.chosen = false
    hand.remove_cards([card])

    joker_card = @round.find_card(value: 'joker')
    if joker_card.rank == card.rank && joker_card.suite == card.suite
      joker_card.chosen = false
      joker_card.rank = nil
      joker_card.suite = nil
      hand << @round.replace_card(value: 'joker', card: card)
      return true
    end

    joker_card = @round.find_card(value: 'joker2')
    if joker_card.rank == card.rank && joker_card.suite == card.suite
      joker_card.chosen = false
      joker_card.rank = nil
      joker_card.suite = nil
      hand << @round.replace_card(value: 'joker2', card: card)
      return true
    end

    false
  end
end

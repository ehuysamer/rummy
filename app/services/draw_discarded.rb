class DrawDiscarded
  attr_reader :errors

  def initialize(round: nil, player: nil, card: nil)
    @round = round
    @player = player
    @card = card
    @errors = []
  end

  def call
    #TODO: Refactor: selected_player_can_play

    if @player.melds.length == 0 && @round.discard.cards_from(@card).length > 1
      @errors << 'You cannot draw more than one card from the discard pile until you have created a meld'
      return false
    end

    player.card_must_use(@card)

    cards = @round.discard.sweep_from(@card)

    cards.each{ |card| card.chosen = true }

    @player.hand.concat(cards)
    @player.has_drawn_card = true

    true
  end

  private

  attr_reader :round, :player, :card
end

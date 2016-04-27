class DrawCard
  def initialize(player, round)
    @player = player
    @round = round
  end

  def call
    @player.has_drawn_card = true

    #TODO: When no cards left to draw, turn around discard stack
    #TODO: Naming consistency; stack -> card_stack

    card = @round.pickup.pop
    card.chosen = true
    @player.hand << card

    true
  end
end

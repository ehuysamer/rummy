class Draw
  def initialize(player, round)
    @player = player
    @round = round
  end

  def call
    @player.has_drawn_card = true

    #TODO: When no cards left to draw, turn around discard stack
    #TODO: Naming consistency; stack -> card_stack

    @round.select_player(@player)

    card = @round.pickup.pop
    card.chosen = true
    @round.selected_player.hand << card

    true
  end
end

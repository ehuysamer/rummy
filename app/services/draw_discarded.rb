class DrawDiscarded
  def initialize(round: nil, player: nil, card: nil)
    @round = round
    @player = player
    @card = card
  end

  def call
    #TODO: Move selected player out of round into controllers
    #TODO: Refactor: selected_player_can_play
    #TODO: Only allowed to take the top card if no melds yet
    #TODO: Check selected == current

    #round.selected_player.hand.concat(round.discard.sweep_from(params[:draw]))

    cards = @round.discard.sweep_from(@card)

    cards.each{ |card| card.chosen = true }

    @player.hand.concat(cards)
    @player.has_drawn_card = true

    true
  end

  private

  attr_reader :round, :player, :card
end

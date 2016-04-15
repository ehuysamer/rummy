class DrawDiscarded
  def initialize(round: nil, player: nil, card: nil)
    @round = round
    @player = player
    @card = card
  end

  def call
    #TODO: Check selected == current

    cards = @round.discard.sweep_from(@card)

    @round.selected_player.hand.concat(cards)

    @player.has_drawn_card = true
  end

  private

  attr_reader :round, :player, :card
end

class Discard
  def initialize(round: nil, player: nil, card_value: nil)
    @round = round
    @player = player
    @card_value = card_value
  end

  def call
    #TODO: Player rotation occurs on discard
    #TODO: Check if player has used the card if he swiped

    #round.discard << round.selected_player.hand.remove_by_value(params[:discard])

    #TODO: Report errors
    # if @cards.length != 1
    #   return false
    # end

    @round.selected_player.hand.cards.each {|card| card.chosen = false}

    @round.selected_player.has_drawn_card = false
    @round.discard << @round.selected_player.hand.remove_by_value(value: @card_value)

    @round.next_player

    return true
  end
end

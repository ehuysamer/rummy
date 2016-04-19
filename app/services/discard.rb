class Discard
  def initialize(round: nil, player: nil, card_value: nil)
    @round = round
    @player = player
    @card_value = card_value
  end

  def call
    #TODO: Check if player has used the card if he swiped more than 1

    #round.discard << round.selected_player.hand.remove_by_value(params[:discard])

    #TODO: Report errors
    # if @cards.length != 1
    #   return false
    # end

    @player.hand.cards.each {|card| card.chosen = false}

    @player.has_drawn_card = false
    @round.discard << @player.hand.remove_by_value(value: @card_value)
    
    true
  end
end

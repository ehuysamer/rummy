class Discard
  def initialize(round: nil, player: nil, card_id: nil)
    @round = round
    @player = player
    @card_id = card_id
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
    @round.discard << @player.hand.remove_by_id(id: @card_id)
    
    true
  end
end

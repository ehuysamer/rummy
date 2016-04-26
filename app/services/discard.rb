class Discard
  attr_reader :errors

  def initialize(round: nil, player: nil, card_id: nil)
    @round = round
    @player = player
    @card_id = card_id
    @errors = []
  end

  def call
    if @player.card_must_use_id
      @errors << "You have not used the card that you picked up from the discard pile. Use UNDO if you are stuck."
      return false
    end

    @player.hand.cards.each {|card| card.chosen = false}

    card_discarded = @player.hand.remove_card(id: @card_id)
    if card_discarded.nil?
      @errors << "You cannot discard a card that you don't have"
      return false
    end

    @player.has_drawn_card = false
    @round.discard << card_discarded

    true
  end
end

#round.discard << round.selected_player.hand.remove_by_value(params[:discard])


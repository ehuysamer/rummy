class Meld
  attr_reader :errors

  def initialize(round: nil, player: nil, cards: nil)
    @round = round
    @player = player
    @cards = cards
    @errors = []
  end

  def call
    meld = round.find_meld(cards)

    if cards.all? { |card| card.has_value? }
      @errors << 'You must set the rank and suite for the joker(s) that you want to meld'
      return false
    end

    unless meld
      @errors << 'You are attempting to create a meld that is invalid'
      return false
    end

    if meld.cards.length == 0
      meld.owner = player
    elsif player.melds.length == 0
      errors << "You can't attach cards until you've created a meld"
      return false
    end

    cards.each{|card| player.hand.move_to(id: card.id, stack: meld)}

    cards.each do |card|
      card.owner = player

      if player.card_must_use_id == card.id
        player.card_must_use(nil)
      end
    end

    if player.won?
      @round.next_player
    end

    true
  end

  private

  attr_reader :round, :player, :cards
end

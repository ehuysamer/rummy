class Meld
  def initialize(round: nil, player: nil, cards: nil)
    @round = round
    @player = player
    @cards = cards
  end

  def call
    meld = round.find_meld(cards)

    unless meld.nil?
      if meld.cards.length == 0
        meld.owner = player

        #TODO: Remove melds object from player
        player.melds << meld
      end

      #TODO: Prevent melding with jokers if values not properly set

      meld.concat(cards)
      player.hand.remove_cards(cards)
      cards.each {|card| card.owner = player}

      if player.won?
        @round.next_player
      end
    end

    true
  end

  private

  attr_reader :round, :player, :cards
end

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

    unless meld.nil?
      if meld.cards.length == 0
        meld.owner = player
        player.melds << meld
      end

      if cards.detect { |card| card.joker && (card.suite.nil? || card.rank.nil?) }
        @errors << "You must set the rank and suite for the joker(s) that you want to meld"
        return false
      end

      meld.concat(cards)
      player.hand.remove_cards(cards)
      cards.each do |card|
        card.owner = player

        if player.card_must_use_id == card.id
          player.card_must_use(nil)
        end
      end

      if player.won?
        @round.next_player
      end
    end

    true
  end

  private

  attr_reader :round, :player, :cards
end

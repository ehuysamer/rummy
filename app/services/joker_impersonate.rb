class JokerImpersonate
  attr_reader :errors

  def initialize(round, player, joker1, joker2)
    @round = round
    @player = player
    @joker1 = joker1
    @joker2 = joker2
    @errors = []
  end

  def call
    if @joker1
      if (card = player.hand.find(id: 'joker'))
        card.rank = Card.rank_by_id(@joker1)
        card.suite = Card.suite_by_id(@joker1)
      else
        @errors << "You cannot set the replacement card for a joker that you don't own"
        return false
      end
    end

    if @joker2
      if (card = player.hand.find(id: 'joker2'))
        card.rank = Card.rank_by_id(@joker2)
        card.suite = Card.suite_by_id(@joker2)
      else
        @errors << "You cannot set the replacement card for a joker that you don't own"
        return false
      end
    end

    true
  end

  private

  attr_reader :player, :joker1, :joker2, :round
end

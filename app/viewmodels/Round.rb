class Round
  attr_reader :pickup
  attr_reader :discard

  attr_reader :player_hands

  attr_reader :melds

  @@round = nil

  CARDS_DEALT = {
      2 => 10,
      3 => 7,
      4 => 7,
      5 => 6,
      6 => 6
  }

  def initialize(num_players)
    @pickup = CardStack.new
    @pickup.add_all
    @pickup.shuffle

    @player_hands = (1..num_players).map { CardStack.new }

    CARDS_DEALT[num_players].times do
      @player_hands.each { |hand| hand << @pickup.pop }
    end

    @discard = CardStack.new
    @discard << @pickup.pop

    @melds = []
    (1..13).each { |rank| @melds << CardStack.new(rank: rank) }
    %w(H C S D).each { |suite| @melds << CardStack.new(suite: suite) }
  end

  def self.get(game_id: nil)
    @@round ||= Round.new(4)
  end

  def find_meld(cards)
    melds.find { |meld| meld.can_meld(cards) }
  end
end

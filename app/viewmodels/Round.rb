class Round
  attr_reader :pickup
  attr_reader :discard

  attr_reader :player_hands

  attr_reader :rank_melds
  attr_reader :suite_melds

  @@round = nil

  CARDS_DEALT = {
      2 => 10,
      3 => 7,
      4 => 7,
      5 => 6,
      6 => 6
  }

  def initialize(num_players)
    @pickup = Stack.new
    @pickup.add_all
    @pickup.shuffle

    @player_hands = (1..num_players).map { Stack.new }

    CARDS_DEALT[num_players].times do
      @player_hands.each { |hand| hand << @pickup.pop }
    end

    @discard = Stack.new
    @discard << @pickup.pop
  end

  def self.get(game_id: nil)
    @@round ||= Round.new(4)
  end
end

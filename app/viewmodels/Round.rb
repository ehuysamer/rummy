class Round
  attr_reader :pickup
  attr_reader :discard

  #attr_reader :player_hands
  attr_reader :players
  attr_reader :current_player

  attr_reader :melds

  @@round = nil

  CARDS_DEALT = {
      2 => 10,
      3 => 7,
      4 => 7,
      5 => 6,
      6 => 6
  }

  #TODO: stack.score

  #TODO: #CURRENT: UI: cards owned by player in meld not owned by player

  def initialize(num_players)
    @pickup = CardStack.new
    @pickup.add_all
    @pickup.shuffle

    @players = (1..num_players).map do |index|
      hand = CardStack.new
      Player.new('Player ' + index.to_s, hand)
    end

    @current_player = @players[0]

    #@player_hands = (1..num_players).map { CardStack.new }

    CARDS_DEALT[num_players].times do
      @players.each { |player| player.hand << @pickup.pop }
    end

    @discard = CardStack.new
    @discard << @pickup.pop

    @melds = []
    (1..13).each { |rank| @melds << CardStack.new(rank: rank) }
    %w(H C S D).each { |suite| @melds << CardStack.new(suite: suite) }

    Meld.new(round: self, player: @players[1], cards: [
        Card.new(suite: 'H', rank: 3, value: 'D3'),
        Card.new(suite: 'S', rank: 3, value: 'S3'),
        Card.new(suite: 'D', rank: 3, value: 'D3')
    ]).call()

    Meld.new(round: self, player: @players[2], cards: [
        Card.new(suite: 'H', rank: 4, value: 'H3'),
        Card.new(suite: 'H', rank: 5, value: 'H5'),
        Card.new(suite: 'H', rank: 6, value: 'H6'),
        Card.new(suite: 'H', rank: 7, value: 'H7')
    ]).call()

    Meld.new(round: self, player: @players[2], cards: [
        Card.new(suite: 'H', rank: 5, value: 'H5'),
        Card.new(suite: 'S', rank: 5, value: 'S5'),
        Card.new(suite: 'D', rank: 5, value: 'D5')
    ]).call()

    Meld.new(round: self, player: @players[3], cards: [
        Card.new(suite: 'H', rank: 8, value: 'H8'),
        Card.new(suite: 'S', rank: 8, value: 'S8'),
        Card.new(suite: 'D', rank: 8, value: 'D8')
    ]).call()

    Meld.new(round: self, player: @current_player, cards: [
        Card.new(suite: 'H', rank: 2, value: 'H2'),
        Card.new(suite: 'S', rank: 2, value: 'S2'),
        Card.new(suite: 'D', rank: 2, value: 'D2')
    ]).call()

    @current_player.hand << Card.new(suite: 'C', rank: 3, value: 'C3')
    @current_player.hand << Card.new(suite: 'C', rank: 5, value: 'C5')
  end

  def self.get(game_id: nil)
    @@round ||= Round.new(4)
  end

  def find_meld(cards)
    melds.find { |meld| meld.can_meld(cards) }
  end
end

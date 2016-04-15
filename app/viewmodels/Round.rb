class Round
  attr_reader :pickup
  attr_reader :discard
  attr_reader :melds

  attr_reader :players

  #TODO: #REFACTOR: rename -> current_player_turn
  attr_reader :current_player

  attr_reader :selected_player

  @@round = nil

  CARDS_DEALT = {
      2 => 10,
      3 => 7,
      4 => 7,
      5 => 6,
      6 => 6
  }

  #TODO: stack.score

  def initialize(num_players)
    @pickup = CardStack.new
    @pickup.add_all
    @pickup.shuffle

    @discard = CardStack.new

    @players = (1..num_players).map do |index|
      hand = CardStack.new
      Player.new(index - 1, 'Player ' + index.to_s, hand)
    end

    @current_player = @players[0]
    @selected_player = @players[0]

    #@player_hands = (1..num_players).map { CardStack.new }

    @melds = []
    (1..13).each { |rank| @melds << CardStack.new(rank: rank) }
    %w(H C S D).each { |suite| @melds << CardStack.new(suite: suite) }


    # joker1 = self.steal_card(value: 'joker')
    # joker1.rank = 3
    # joker1.suite = 'H'
    # joker2 = self.steal_card(value: 'joker2')
    # joker2.rank = 3
    # joker2.suite = 'C'
    # Meld.new(round: self, player: @players[0], cards: [
    #     joker1,
    #     joker2,
    #     Card.new(suite: 'D', rank: 3, value: 'D3')
    # ]).call()
    # @current_player.hand << self.steal_card(value: 'H3')
    # @current_player.hand << self.steal_card(value: 'C3')



    # Meld.new(round: self, player: @players[1], cards: [
    #     Card.new(suite: 'H', rank: 3, value: 'D3'),
    #     Card.new(suite: 'S', rank: 3, value: 'S3'),
    #     Card.new(suite: 'D', rank: 3, value: 'D3')
    # ]).call()
    #
    # Meld.new(round: self, player: @players[2], cards: [
    #     Card.new(suite: 'H', rank: 4, value: 'H3'),
    #     Card.new(suite: 'H', rank: 5, value: 'H5'),
    #     Card.new(suite: 'H', rank: 6, value: 'H6'),
    #     Card.new(suite: 'H', rank: 7, value: 'H7')
    # ]).call()
    #
    # Meld.new(round: self, player: @players[2], cards: [
    #     Card.new(suite: 'H', rank: 5, value: 'H5'),
    #     Card.new(suite: 'S', rank: 5, value: 'S5'),
    #     Card.new(suite: 'D', rank: 5, value: 'D5')
    # ]).call()
    #
    # Meld.new(round: self, player: @players[3], cards: [
    #     Card.new(suite: 'H', rank: 8, value: 'H8'),
    #     Card.new(suite: 'S', rank: 8, value: 'S8'),
    #     Card.new(suite: 'D', rank: 8, value: 'D8')
    # ]).call()
    #
    # Meld.new(round: self, player: @current_player, cards: [
    #     Card.new(suite: 'H', rank: 2, value: 'H2'),
    #     Card.new(suite: 'S', rank: 2, value: 'S2'),
    #     Card.new(suite: 'D', rank: 2, value: 'D2')
    # ]).call()
    #
    # @current_player.hand << Card.new(suite: 'C', rank: 3, value: 'C3')
    # @current_player.hand << Card.new(suite: 'C', rank: 5, value: 'C5')
  end

  #TODO: #REFACTOR: rename -> can_draw_card?
  def can_draw_card
    !player_won && selected_player && !selected_player.has_drawn_card
  end

  #TODO: #REFACTOR: rename -> can_play_hand?
  def can_play_hand
    !player_won && selected_player && selected_player.has_drawn_card
  end

  def deal
    CARDS_DEALT[@players.length].times do
      @players.each { |player| player.hand << @pickup.pop }
    end

    # while players[1].hand.cards.length > 0
    #   players[1].hand.pop
    # end

    @discard << @pickup.pop

    self
  end

  def self.reset(game_id: nil)
    @@round = nil
  end

  def self.get(game_id: nil)
    @@round ||= Round.new(4).deal
  end

  def select_player(player)
    @selected_player = player
  end

  def find_meld(cards)
    melds.find { |meld| meld.can_meld(cards) }
  end

  def find_card(suite: nil, rank: nil, value: nil)
    pickup.find(value: value, rank: rank, suite: suite) ||
        discard.find(value: value, rank: rank, suite: suite) ||
        (melds.select{|meld| meld.find(value: value, rank: rank, suite: suite) }.first&.find(value: value, rank: rank, suite: suite)) ||
        (players.select{|player| player.hand.find(value: value, rank: rank, suite: suite) }.first&.hand&.find(value: value, rank: rank, suite: suite))
  end

  def replace_card(value: nil, rank: nil, suite: nil, card: nil)
    pickup.replace_by_value(value: value, rank: rank, suite: suite, card: card) ||
        discard.replace_by_value(value: value, rank: rank, suite: suite, card: card) ||
        (melds.select{|meld| meld.find(value: value, rank: rank, suite: suite) }.first&.replace_by_value(value: value, rank: rank, suite: suite, card: card)) ||
        (players.select{|player| player.hand.find(value: value, rank: rank, suite: suite) }.first&.hand&.replace_by_value(value: value, rank: rank, suite: suite, card: card))
  end

  def steal_card(suite: nil, rank: nil, value: nil)
    pickup.remove_by_value(value: value, rank: rank, suite: suite) ||
        discard.remove_by_value(value: value, rank: rank, suite: suite) ||
        (melds.select{|meld| meld.find(value: value, rank: rank, suite: suite) }.first&.remove_by_value(value: value, rank: rank, suite: suite)) ||
        (players.select{|player| player.hand.find(value: value, rank: rank, suite: suite) }.first&.hand&.remove_by_value(value: value, rank: rank, suite: suite))
  end

  def next_player
    index = players.index(@current_player)
    index = (index + 1) % players.length
    @current_player = players[index]
  end

  def player_won
    players.select{ |player| player.has_won }.first
  end
end

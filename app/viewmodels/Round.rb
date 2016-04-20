class Round
  attr_reader :pickup
  attr_reader :discard
  attr_reader :melds

  attr_reader :players

  #TODO: #REFACTOR: rename -> current_player_turn
  attr_accessor :current_player

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

    @discard = CardStack.new

    @players = (0...num_players).map do |index|
      hand = CardStack.new
      Player.new(index, 'Player ' + (index + 1).to_s, hand, self)
    end

    @current_player = @players[0]

    @melds = []
    (1..13).each { |rank| @melds << CardStack.new(rank: rank) }
    %w(S H C D).each { |suite| @melds << CardStack.new(suite: suite) }
  end

  def can_draw_card?
    !player_won && selected_player && !current_player.has_drawn_card && selected_player == current_player
  end

  def can_play_hand?
    !player_won && selected_player && current_player.has_drawn_card && selected_player == current_player
  end

  def shuffle
    @pickup.shuffle
    self
  end

  def deal
    CARDS_DEALT[@players.length].times do
      @players.each { |player| player.hand << @pickup.pop }
    end

    @discard << @pickup.pop

    self
  end

  def self.reset(game_id: nil)
    @@round = nil
  end

  def self.get(game_id: nil)
    @@round ||= Round.new(4).shuffle.deal
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

  def find_cards_by_value(values)
    values.map { |value| find_card(value: value) }
  end

  def replace_card(value: nil, rank: nil, suite: nil, card: nil)
    pickup.replace_by_value(value: value, rank: rank, suite: suite, card: card) ||
        discard.replace_by_value(value: value, rank: rank, suite: suite, card: card) ||
        (melds.select{|meld| meld.find(value: value, rank: rank, suite: suite) }.first&.replace_by_value(value: value, rank: rank, suite: suite, card: card)) ||
        (players.select{|player| player.hand.find(value: value, rank: rank, suite: suite) }.first&.hand&.replace_by_value(value: value, rank: rank, suite: suite, card: card))
  end

  #TODO: , card:nil
  def steal_card(suite: nil, rank: nil, value: nil)
    pickup.remove_by_value(value: value, rank: rank, suite: suite) ||
        discard.remove_by_value(value: value, rank: rank, suite: suite) ||
        (melds.select{|meld| meld.find(value: value, rank: rank, suite: suite) }.first&.remove_by_value(value: value, rank: rank, suite: suite)) ||
        (players.select{|player| player.hand.find(value: value, rank: rank, suite: suite) }.first&.hand&.remove_by_value(value: value, rank: rank, suite: suite))
  end

  def player_id(player)
    players.index(player)
  end

  def current_player_id
    players.index(@current_player)
  end

  def next_player
    index = player_id(@current_player)
    index = (index + 1) % players.length
    @current_player = players[index]
  end

  def player_by_id(id)
    players[id.to_i]
  end

  def player_won
    players.select{ |player| player.won? }.first
  end

  private

  attr_reader :selected_player
end


# joker1 = self.steal_card(value: 'joker')
# #joker1.rank = 3
# #joker1.suite = 'H'
# @current_player.hand << joker1
#
# joker2 = self.steal_card(value: 'joker2')
# #joker2.rank = 3
# #joker2.suite = 'C'
# @current_player.hand << joker2
#
# @current_player.hand << self.steal_card(value: 'H3')
# @current_player.hand << self.steal_card(value: 'C3')
# card = self.steal_card(value: 'D3')
# @current_player.hand << card
# # Meld.new(round: self, player: @players[0], cards: [
# #     joker1,
# #     joker2,
# #     card
# # ]).call()
#
# @current_player.hand << self.steal_card(value: 'H7')
# @current_player.hand << self.steal_card(value: 'C7')
# @current_player.hand << self.steal_card(value: 'D7')
# #@current_player.hand << self.steal_card(value: 'joker')


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
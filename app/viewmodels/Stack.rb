class Stack
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_all
    %w(H C D S).each do |suite|
      %w(A 2 3 4 5 6 7 8 9 10 J Q K).each do |rank|
        @cards << Card.new(suite: suite, rank: rank, value: suite + rank)
      end
    end

    @cards << Card.new(value: 'joker')
    @cards << Card.new(value: 'joker')
  end

  def <<(card)
    @cards << card
  end

  def pop
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end

  def length
    @cards.length
  end
end

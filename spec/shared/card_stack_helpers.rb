module CardStackHelpers
  def cards_from_values(values)
    values.map do |value|
      suite = nil
      rank = Card.rank_of_value(value)

      if value[0] == 'J'
        suite = value[1] if value.length >= 2
        Card.new(suite: suite, rank: rank, value: 'JOKER')
      else
        suite = value[0]
        Card.new(suite: suite, rank: rank, value: value) #(suite + rank.to_s))
      end
    end
  end
end

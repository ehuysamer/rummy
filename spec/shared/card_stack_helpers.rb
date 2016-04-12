module CardStackHelpers
  def cards_from_values(*values)
    values.map do |value|
      suite = nil
      rank = nil

      if value[0] == 'J'
        suite = value[1] if value.length >= 2
        rank = value[2].to_i if value.length >= 3
        Card.new(suite: suite, rank: rank, value: 'JOKER')
      else
        suite = value[0]
        rank = value[1].to_i
        Card.new(suite: suite, rank: rank, value: (suite + rank.to_s))
      end
    end
  end
end

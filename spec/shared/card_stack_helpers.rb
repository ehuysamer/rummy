module CardStackHelpers
  def cards_from_values(values)
    values.map do |value|
      suite = nil
      rank = Card.rank_of_value(value)

      if value[0] == 'J'
        suite = value[1] if value.length >= 2
        Card.new(suite: suite, rank: rank, value: value, joker: true)
      else
        suite = value[0]
        Card.new(suite: suite, rank: rank, value: value, joker: false) #(suite + rank.to_s))
      end
    end
  end
end

#TODO: Move to more common level
RSpec::Matchers.define :have_all do |expected|
  match do |actual|
    !expected.any?{ |item| !actual.include? item }
  end
  failure_message do |actual|
    "expected #{actual} to have all the elements in #{expected}"
  end
end

RSpec::Matchers.define :have_none do |expected|
  match do |actual|
    expected.all?{ |item| !actual.include? item }
  end
  failure_message do |actual|
    "expected #{actual} to have none of the elements in #{expected}"
  end
end

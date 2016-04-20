module CardStackHelpers
  def cards_from_ids(ids)
    ids.map do |id|
      suite = nil
      rank = Card.rank_by_id(id)

      if id[0] == 'J'
        suite = id[1] if id.length >= 2
        Card.new(suite: suite, rank: rank, id: id, joker: true)
      else
        suite = id[0]
        Card.new(suite: suite, rank: rank, id: id, joker: false) #(suite + rank.to_s))
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

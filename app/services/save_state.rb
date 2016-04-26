class SaveState
  def initialize(round)
    @round = round
  end

  def call
    @round.save
  end

  private

  attr_reader :round

end

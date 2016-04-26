class UndoTurn
  def initialize(round)
    @round = round
  end

  def call
    @round.undo
  end

  private

  attr_reader :round

end

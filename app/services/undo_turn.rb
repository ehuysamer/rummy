class UndoTurn
  def initialize(round)
    @round = round
  end

  def call
    if @round.can_undo?
      @round.undo
      true
    end
  end

  private

  attr_reader :round

end

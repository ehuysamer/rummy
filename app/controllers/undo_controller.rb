class UndoController < ApplicationController
  include PlayerConcern

  def create
    UndoTurn.new(@round).call

    redirect_to_current_round
  end
end

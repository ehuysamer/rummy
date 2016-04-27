class UndoController < ApplicationController
  include PlayerConcern

  def create
    return unless handle_can_play

    UndoTurn.new(@round).call

    redirect_to_current_round
  end
end

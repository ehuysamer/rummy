class UndoController < ApplicationController
  include PlayerConcern

  def create
    UndoTurn.new(@round).call

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end

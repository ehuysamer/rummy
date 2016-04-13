class DrawDiscardedController < ApplicationController
  def create
    round = Round.get(game_id: 1)
    round.players[0].hand.concat(round.discard.sweep_from(params[:draw]))

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end

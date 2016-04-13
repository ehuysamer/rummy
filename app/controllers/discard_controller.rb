class DiscardController < ApplicationController
  def create
    round = Round.get(game_id: 1)
    round.discard << round.players[0].hand.remove_by_value(params[:discard])

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end

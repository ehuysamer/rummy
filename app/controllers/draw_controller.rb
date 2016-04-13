class DrawController < ApplicationController
  def create
    round = Round.get(game_id: 1)
    round.players[0].hand << round.pickup.pop

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end
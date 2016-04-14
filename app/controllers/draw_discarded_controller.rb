class DrawDiscardedController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i
    round.select_player(round.players[player_id])

    round.selected_player.hand.concat(round.discard.sweep_from(params[:draw]))

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end

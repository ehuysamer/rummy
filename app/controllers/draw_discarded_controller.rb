class DrawDiscardedController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i

    player = round.players[player_id]
    player.has_drawn_card = true
    round.select_player(player)

    round.selected_player.hand.concat(round.discard.sweep_from(params[:draw]))

    #TODO: Only allowed to take the top card if no melds yet

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end

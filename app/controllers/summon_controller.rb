class SummonController < ApplicationController
  def create
    round = Round.get(game_id: params[:game_id])

    player_id = params[:player_id].to_i
    player = round.players[player_id]
    round.select_player(player)

    player.hand.concat(params[:card].split(',').map{|id| round.steal_card(id: id)})
    #round.selected_player.hand.concat(params[:card].split(',').map{|value| Card.create_from_value(value)})

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end


class MeldController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i
    round.select_player(round.players[player_id])

    cards = params[:cards]

    selected = round.selected_player.hand.select(cards.map {|k,v| k})

    Meld.new(round: round, player: round.selected_player, cards: selected).call()

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end

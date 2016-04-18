class JokerGrabController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i
    round.select_player(round.players[player_id])

    hand = round.selected_player.hand
    card = hand.find(value: params[:card])

    joker_card = round.find_card(value: 'joker')
    if joker_card.rank == card.rank && joker_card.suite == card.suite
      joker_card.rank = nil
      joker_card.suite = nil
      hand << round.replace_card(value: 'joker', card: card)
    end

    joker_card = round.find_card(value: 'joker2')
    if joker_card.rank == card.rank && joker_card.suite == card.suite
      joker_card.rank = nil
      joker_card.suite = nil
      hand << round.replace_card(value: 'joker2', card: card)
    end

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end

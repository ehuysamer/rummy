class MeldController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i
    round.select_player(round.players[player_id])

    #byebug

    cards = params[:cards]

    #selected = cards.select{|k,v|v.length>1}.map{|k,v| k}
    #selected = round.selected_player.hand.select(cards&.map {|k,v| k})

    selection_submitted = cards.select{|k,v|v.length>1}.map{|k,v| k}
    selected = round.selected_player.hand.select(selection_submitted)

    #TODO: Check if joker is in particular players' hand
    joker1 = params[:joker1]
    if joker1
      card = round.find_card(value: 'joker')
      card.rank = Card.rank_of_value(joker1)
      card.suite = Card.suite_of_value(joker1)
    end

    joker2 = params[:joker2]
    if joker2
      card = round.find_card(value: 'joker2')
      card.rank = Card.rank_of_value(joker2)
      card.suite = Card.suite_of_value(joker2)
    end

    Meld.new(round: round, player: round.selected_player, cards: selected).call

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end

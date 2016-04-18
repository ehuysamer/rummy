class MeldController < ApplicationController
  include PlayerConcern

  def create
    #TODO: Figure out why the weird data getting passed in from the view form

    cards = params[:cards]

    #selected = cards.select{|k,v|v.length>1}.map{|k,v| k}
    #selected = round.selected_player.hand.select(cards&.map {|k,v| k})

    selection_submitted = cards.select{|k,v|v.length>1}.map{|k,v| k}
    selected = @round.selected_player.hand.select(selection_submitted)

    joker1 = params[:joker1]
    joker2 = params[:joker2]
    if joker1 || joker2
      JokerImpersonate.new(@round, @player, joker1, joker2).call
    end

    Meld.new(round: @round, player: @round.selected_player, cards: selected).call

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end

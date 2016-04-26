class MeldController < ApplicationController
  include PlayerConcern

  def create
    #TODO: Figure out why the weird data getting passed in from the view form

    cards = params[:cards]

    #selected = cards.select{|k,v|v.length>1}.map{|k,v| k}
    #selected = round.selected_player.hand.select(cards&.map {|k,v| k})

    selection_submitted = cards.select{|k,v|v.length>1}.map{|k,v| k}
    selected = @player.hand.select(selection_submitted)

    joker1 = params[:joker1]
    joker2 = params[:joker2]
    if joker1 || joker2
      joker_impersonate = JokerImpersonate.new(@round, @player, joker1, joker2)
      if !joker_impersonate.call
        flash[:notice] = joker_impersonate.errors.join('<br/>')
        redirect_to_current_round
        return
      end
    end

    meld_service = Meld.new(round: @round, player: @player, cards: selected)
    if !meld_service.call
      flash[:notice] = meld_service.errors.join('<br/>')
    end

    redirect_to_current_round
  end
end

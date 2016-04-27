class MeldController < ApplicationController
  include PlayerConcern

  def create
    return unless handle_can_play

    #TODO: Figure out why the weird data getting passed in from the view form
    cards = params[:cards]
    #selected = cards.select{|k,v|v.length>1}.map{|k,v| k}
    #selected = round.selected_player.hand.select(cards&.map {|k,v| k})
    selection_submitted = cards.select{|k,v|v.length>1}.map{|k,v| k}

    selected = @player.hand.select(selection_submitted)

    joker1 = params[:joker1]
    if joker1
      joker_impersonate = JokerImpersonate.new(round: @round, player: @player, joker_id: Card::JOKER[0], value: joker1)
      unless joker_impersonate.call
        show_errors(joker_impersonate.errors)
        redirect_to_current_round
        return
      end
    end

    joker2 = params[:joker2]
    if joker2
      joker_impersonate = JokerImpersonate.new(round: @round, player: @player, joker_id: Card::JOKER[1], value: joker2)
      unless joker_impersonate.call
        show_errors(joker_impersonate.errors)
        redirect_to_current_round
        return
      end
    end

    meld_service = Meld.new(round: @round, player: @player, cards: selected)
    meld_service.call
    show_errors(meld_service.errors)

    redirect_to_current_round
  end
end

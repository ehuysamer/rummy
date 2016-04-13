class MeldController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    picked = round.current_player.hand.pick(params[:cards].map {|k,v| k})

    picked.each { |card| card.owner = round.current_player }

    meld = round.find_meld(picked)
    #TODO: What if meld is nil

    #TODO: This should be in a service

    unless meld.nil?
      if meld.cards.length == 0
        meld.owner = round.current_player
        round.current_player.melds << meld
      end

      meld.concat(picked)
      meld.owner = round.current_player
    end

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end

#TODO: meld owner
#TODO: card owner

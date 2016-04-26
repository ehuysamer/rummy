module PlayerConcern
  extend ActiveSupport::Concern

  included do
    before_action :game_from_parameters
    before_action :player_from_parameters, except: [:index, :new]
  end

  def game_from_parameters
    @game_id = player_params[:game_id]
    @round = Round.get(game_id: @game_id)
  end

  def player_from_parameters
    @player_id = player_id.to_i
    @player = @round.player_by_id(@player_id)

    @round.select_player(@player)
  end

  def player_id
    player_params[:player_id]
  end

  def redirect_to_current_round
    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end

  private

  def player_params
    params.permit(:game_id, :player_id, :id)
  end
end

# def set_game
#   current_game = Game.find_by(id: params[:id])
#   @game = RoundPresenter.new(current_game)
# end
# def game_params
#   params.require(:game).permit(:target_word)
# end

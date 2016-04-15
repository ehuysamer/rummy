require 'rails_helper'

RSpec.describe DrawDiscardedController, type: :controller do
  describe "POST Create" do

    context 'Round with 4 players' do
      let(:round) { Round.get }

      before do
        %w(H2 H3 H4 H5 H6 H7 H8).each { |card| round.discard << round.steal_card(value: card) }
        %w(S2 S3 S4 S5).each { |card| round.players[0].hand << round.steal_card(value: card) }
        %w(S6 S7 S8 S9).each { |card| round.players[1].hand << round.steal_card(value: card) }
        %w(D2 D3 D4 D5).each { |card| round.players[2].hand << round.steal_card(value: card) }
        %w(D6 D7 D8 D9).each { |card| round.players[3].hand << round.steal_card(value: card) }

        round.select_player(round.players[0])
      end

      describe 'post create' do
        before do
          post :create, game_id: 1, player_id: 0, :draw => 'H5'
        end

        it 'has the cards swiped' do
          expect(round.players[0].hand.cards.map{|card| card.value}).to have_all %w(H5 H6 H7 H8)
        end

        it 'has the cards it had previously' do
          expect(round.players[0].hand.cards.map{|card| card.value}).to have_all %w(S2 S3 S4 S5)
        end

        it 'leaves the other cards on the discard pile' do
          expect(round.discard.cards.map{|card| card.value}).to have_all %w(H2 H3 H4)
        end

        it 'takes the cards away from discard pile' do
          expect(round.discard.cards.map{|card| card.value}).to have_none %w(H5 H6 H7 H8)
        end

        it 'redirects to show' do
          expect(response.status).to eq 302
        end

        it 'redirects to show' do
          expect(response).to redirect_to game_player_url(game_id: 1, id: 0)
        end
      end
    end
  end
end

# expect(response).to redirect_to :action => :show, :controller => PlayersController, :game_id => 1, :player_id => 1
# expect(response).to redirect_to game_player_url(assigns(:player)) # assigns implies something getting passed to a view
#post :create, { :widget => {:game_id => 1, :player_id => 1, :draw => 'H2' }}
#expect(response.status).to eq(302)
# expect(response).to render_template(:new)
# expect(response).to redirect_to(location)
# expect(response).to have_http_status(:created)
# expect(response).to be_a_new(Widget)


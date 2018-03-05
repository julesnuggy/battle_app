require 'sinatra/base'

class Battle < Sinatra::Base

  get '/' do
    erb(:start_screen)
  end

  get '/start-new-game' do
    erb(:new_game_form)
  end

  post '/display-players' do
    @player1_name = params[:player1_name]
    @player2_name = params[:player2_name]
    erb(:index)
  end

  run! if app_file == $0
end

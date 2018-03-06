require 'sinatra/base'

class Battle < Sinatra::Base
enable :sessions

  get '/' do
    erb(:start_screen)
  end

  get '/start-new-game' do
    erb(:new_game_form)
  end

  post '/display-players' do
    session[:player1_name] = params[:player1_name]
    session[:player2_name] = params[:player2_name]
    redirect to('/play'), 303
  end

  get '/play' do
    @player1_name = session[:player1_name].inspect
    @player2_name = session[:player2_name].inspect
    erb(:index)
  end

  run! if app_file == $0
end

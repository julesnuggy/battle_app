require 'sinatra/base'
require 'sysrandom/securerandom'

class Battle < Sinatra::Base
enable :sessions
set :session_secret, 'My Secret Session'
# session_secret needed for sessions to redirect params correctly

# set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
# Yet to work out how to implement this properly
# http://sinatrarb.com/intro.html#Using%20Sessions

  get '/' do
    erb(:start_screen)
  end

  get '/start-new-game' do
    erb(:new_game_form)
  end

  post '/store-names' do
    session[:player1_name] = params[:player1_name]
    session[:player2_name] = params[:player2_name]
    redirect '/character-screen'
  end

  get '/character-screen' do
    @player1_name = session[:player1_name]
    @player2_name = session[:player2_name]
    erb(:character_screen)
  end

  get '/match' do
    @battle_message = "#{@player1_name}, your turn..."
    @player1_name = session[:player1_name]
    @player2_name = session[:player2_name]
    @p1_max_hp = @p2_max_hp = 100
    @p1_curr_hp = @p2_curr_hp = 100
    erb(:match)
  end

  run! if app_file == $0
end

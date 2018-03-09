require 'sinatra/base'
require 'sysrandom/securerandom'
require_relative './lib/player.rb'
require_relative './lib/game.rb'

class Battle < Sinatra::Base
enable :sessions
set :session_secret, 'My Secret Session'
# session_secret needed for sessions to redirect params correctly

# set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
# Yet to work out how to implement this properly
# http://sinatrarb.com/intro.html#Using%20Sessions

  before do
    @game = Game.return_instance
  end

  get '/' do
    erb(:start_screen)
  end

  get '/start-new-game' do
    erb(:new_game_form)
  end

  post '/store-names' do
    player1 = Player.new(params[:player1_name])
    player2 = Player.new(params[:player2_name])
    @game = Game.create_game(player1, player2)
    redirect '/character-screen'
  end

  get '/character-screen' do
    erb(:character_screen)
  end

  get '/battle' do
    @battle_message = @game.message
    erb(:battle)
  end

  get '/target_self' do
    @game.set_target(@game.turn)
    @battle_message = @game.message(:target, @game.turn, @game.turn)
    erb(:battle)
  end

  get '/target_opponent' do
    @game.set_target(@game.opponent)
    @battle_message = @game.message(:target, @game.turn, @game.opponent)
    erb(:battle)
  end

  get '/phys_attack' do
    @battle_message = @game.message(:attack, @game.turn, @game.target)
    @game.attack(@game.target)
    redirect '/victory' if @game.player1.loser == true || @game.player2.loser == true
    erb(:battle)
  end

  get '/defend_self' do
    @battle_message = @game.message(:defend, @game.turn)
    erb(:battle)
  end

  get '/finish_turn' do
    @game.change_turn
    @battle_message = @game.message(:turn, @game.turn)
    erb(:battle)
  end

  get '/cast_magic' do
    @battle_message = @game.message(:scan, @game.turn, @game.target)
    erb(:battle)
  end

  get '/victory' do
    @victor = @game.player1.loser ? @game.player2 : @game.player1
    erb(:victory)
  end

  run! if app_file == $0
end

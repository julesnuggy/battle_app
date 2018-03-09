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

  get '/comp_battle' do
    @rand_comp_action = @game.rand_comp_action
    @battle_message = @game.message
    erb(:comp_battle)
  end

  get '/battle' do
    @battle_message = @game.message
    @game.reset_actions
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
    @game.attack(@game.target)
    @battle_message = @game.message(:attack, @game.turn, @game.target)
    redirect '/victory' if @game.player1.loser == true || @game.player2.loser == true
    erb(:battle)
  end

  get '/defend_self' do
    @battle_message = @game.message(:defend, @game.turn)
    @game.defend
    erb(:battle)
  end

  get '/finish_turn' do
    @game.change_turn
    @battle_message = @game.message(:turn, @game.turn)
    erb(:battle)
  end

  get '/use_special_atk' do
    @game.attack(@game.target)
    case params[:spc_atk]
      when "bmg_fire"
        @battle_message = @game.message(:fire, @game.turn, @game.target)
      when "bmg_ice"
        @battle_message = @game.message(:ice, @game.turn, @game.target)
      when "teq_tr_thr"
        @battle_message = @game.message(:true_thrust, @game.turn, @game.target)
      when "teq_jump"
        @battle_message = @game.message(:jump, @game.turn, @game.target)
      end

    redirect '/victory' if @game.player1.loser == true || @game.player2.loser == true
    erb(:battle)
  end

  get '/use_special_heal' do
    @game.heal(@game.turn)
    case params[:spc_heal]
      when "wmg_cure"
        @battle_message = @game.message(:cure, @game.turn, @game.target)
      when "teq_recov"
        @battle_message = @game.message(:recover, @game.turn, @game.target)
      end
    erb(:battle)
  end

  get '/use_special_buff' do
    case params[:spc_buff]
      when "wmg_scan"
        @battle_message = @game.message(:scan, @game.turn, @game.target)
      end
    erb(:battle)
  end

  get '/victory' do
    @victor = @game.player1.loser ? @game.player2 : @game.player1
    erb(:victory)
  end

  run! if app_file == $0
end

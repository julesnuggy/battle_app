require 'sinatra/base'
require 'sysrandom/securerandom'
require_relative './lib/player.rb'
require_relative './lib/command.rb'
require_relative './lib/message.rb'

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
    $command = Command.new(Player.new(params[:player1_name]), Player.new(params[:player2_name]))
    redirect '/character-screen'
  end

  get '/character-screen' do
    @command = $command
    erb(:character_screen)
  end

  get '/battle' do
    @command = $command
    @battle_message = $message
    erb(:battle)
  end

  post '/battle_2' do
    @command = $command
    @battle_message = params[:battle_message]
    erb(:battle)
  end



  get '/p1_target' do
    @command = $command
    @command.set_target
    erb(:player_target)
  end

  get '/p1_attack' do
    @command = $command
    @move = :atk
    erb(:player1_moves)
    #redirect '/calc_damage'
  end

  get '/p1_do_damage' do
    @command = $command
    $command.attack(@command.player2)
    redirect '/victory' if @command.player2.loser == true
    @command.change_turn
    erb(:change_turn)
  end

  get '/p1_defend' do
    @command = $command
    @move = :def
    erb(:player1_moves)
  end

  get '/p1_defend_msg' do
    @command = $command
    @command.change_turn
    erb(:change_turn)
  end

  get '/p1_magic' do
    $message = Message.new.scan($command.player2)
    redirect '/battle'
    #@command = $command ## Aim to get to this stage
    #erb(:player_magic) ## Aim to get to this stage
  end



  get '/p2_attack' do
    @command = $command
    @move = :atk
    erb(:player2_moves)
  end

  get '/p2_do_damage' do
    @command = $command
    $command.attack(@command.player1)
    redirect '/victory' if @command.player1.loser == true
    @command.change_turn
    erb(:change_turn)
  end

  get '/p2_defend' do
    @command = $command
    @move = :def
    erb(:player2_moves)
  end

  get '/p2_defend_msg' do
    @command = $command
    @command.change_turn
    erb(:change_turn)
  end

  get '/p2_magic' do
    $message = Message.new.scan($command.player1)
    redirect '/battle'
  end

  get '/victory' do
    @command = $command
    @victor = @command.player1.loser ? @command.player2 : @command.player1
    erb(:victory)
  end

  run! if app_file == $0
end

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
    @player1_name = $command.player1.name
    @player2_name = $command.player2.name
    erb(:character_screen)
  end

  get '/battle' do
    @player1_name = $command.player1.name
    @player2_name = $command.player2.name
    @p1_max_hp = $command.player1.max_hp
    @p2_max_hp = $command.player2.max_hp
    @p1_curr_hp ||= $command.player1.curr_hp
    @p2_curr_hp ||= $command.player2.curr_hp
    @battle_message = ($message ||= "FIGHT")
    erb(:battle)
  end

  get '/p1_attack' do
    @player1_name = $command.player1.name
    @player2_name = $command.player2.name
    $message = ""
    erb(:p1_attack)
  end

  get '/p1_magic' do
    $message = Message.new.scan($command.player2)
    redirect '/battle'
  end

  post '/calc_damage' do
    @player1 = $command.player1
    @player2 = $command.player2
    $command.attack(@player2)
    redirect '/battle'
  end

  run! if app_file == $0
end

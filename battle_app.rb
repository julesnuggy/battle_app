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
    @battle_message = ($message ||= "FIGHT")
    erb(:battle)
  end

  get '/p1_attack' do
    @command = $command
    #$message = "#{@command.player1.name} attacked #{@command.player2.name}!"
    erb(:p1_attack)
    #redirect '/calc_damage'
  end

  get '/p1_magic' do
    $message = Message.new.scan($command.player2)
    redirect '/battle'
  end

  get '/calc_damage' do
    @command = $command
    $command.attack(@command.player2)
    @command.change_turn
    erb(:change_turn)
  end

  run! if app_file == $0
end

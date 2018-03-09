class Game
  attr_reader :player1, :player2, :turn, :message, :target

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn = player1
    @target = player2
    @message = "FIGHT!"
  end

  def self.create_game(player1, player2)
    @game_instance = Game.new(player1, player2)
  end

  def self.return_instance
    @game_instance
  end

  def set_target(target)
    @target = target
  end

  def attack(target)
    target.receive_damage
  end

  def change_turn
    @turn = @turn == player1 ? player2 : player1
    @target = opponent # Reset target
  end

  def opponent
    @opponent = @turn == player1 ? player2 : player1
  end

  def message(action = :fight, actor = "", target = "")
    case action
      when :scan
        @message = "#{actor.name} cast #{action}...\n#{target.name} - HP: #{target.curr_hp}/#{target.max_hp}"
      when :attack
        @message = "#{actor.name} attacked #{target.name}"
      when :defend
        @message = "#{actor.name} defended"
      when :turn
        @message = "#{actor.name}, your turn!"
      when :target
        @message = "Targetting #{target.name}"
      else
        @message = "FIGHT!"
    end
  end

end

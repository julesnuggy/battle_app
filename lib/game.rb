class Game
  attr_reader :player1, :player2, :turn, :message, :target, :defend, :action

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @action = ""
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

  def heal(target)
    target.receive_heal
  end

  def defend
    turn.defend_stance(:on)
  end

  def reset_actions
    turn.defend_stance(:off)
  end

  def change_turn
    @turn = @turn == player1 ? player2 : player1
    @target = opponent # Reset target
  end

  def opponent
    @opponent = @turn == player1 ? player2 : player1
  end

  def message(action = :fight, actor = "", target = "")
    @action = action
    case action
      when :attack
        @message = "#{actor.name} attacked #{target.name} for #{target.damage} damage"
      when :defend
        @message = "#{actor.name} defended"
      when :scan
        @message = "#{actor.name} cast #{action.upcase}... #{target.name} - HP: #{target.curr_hp}/#{target.max_hp}"
      when :cure
        @message = "#{actor.name} cast #{action.upcase}... healed #{target.name} HP by #{target.heal}"
      when :fire
        @message = "#{actor.name} cast #{action.upcase} on #{target.name} for #{target.damage} damage"
      when :ice
        @message = "#{actor.name} cast #{action.upcase} on #{target.name} for #{target.damage} damage"

      when :recover
        @message = "#{actor.name} used #{action.upcase}... healed #{target.name} HP by #{target.heal}"
      when :true_thrust
        @message = "#{actor.name} used #{action.upcase} on #{target.name} for #{target.damage} damage"
      when :jump
        @message = "#{actor.name} used #{action.upcase} on #{target.name} for #{target.damage} damage"

      when :turn
        @message = "#{actor.name}, your turn!"
      when :target
        @message = "Targetting #{target.name}"
      else
        @message = "FIGHT!"
    end
  end

  def rand_comp_action
    @comp_action = ['p2_atk', 'p2_def', 'p2_mag_scan'].sample
  end

end

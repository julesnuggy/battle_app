class Command
  attr_reader :player1, :player2, :turn, :message, :target

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn = player1
    @target = player2
    @message = "FIGHT!"
  end

  def self.create_command(player1, player2)
    @command_instance = Command.new(player1, player2)
  end

  def self.return_instance
    @command_instance
  end

  def attack(target)
    target.receive_damage
  end

  def change_turn
    @turn == player1 ? @turn = player2 : @turn = player1
  end



    def message(action, actor = "", target = "")
      case action
        when :scan
          @message = "Scanned #{target.name} - HP: #{target.curr_hp}/#{target.max_hp}"
        when :attack
          @message = "#{actor.name} attacked #{target.name}"
        else
          @message = "FIGHT!"
      end
    end

    def set_target(target)
      @target = target
    end

end

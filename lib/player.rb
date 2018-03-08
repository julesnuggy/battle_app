require_relative './command.rb'

class Player
  attr_reader :name, :max_hp, :curr_hp, :loser

  def initialize(name, command = Command)
    @name = name
    @command = command
    @max_hp = @curr_hp = 100
  end

  def receive_damage
    @curr_hp -= 10
    lose?
  end

private

  def lose?
    if @curr_hp <= 0
      @loser = true
    end
  end

end

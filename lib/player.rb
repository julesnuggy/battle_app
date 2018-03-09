require_relative './game.rb'

class Player
  attr_reader :name, :max_hp, :curr_hp, :damage, :defend, :heal, :loser

  def initialize(name)
    @name = name
    @damage = 0
    @defend = false
    @max_hp = @curr_hp = 100
  end

  def receive_damage
    @attack = rand(1..10) * 3

    if defend == true
      @defence = (rand(0.1..1) * @attack).round(half: :up)
    else
      @defence = 0
    end

    @damage = @attack - @defence
    @curr_hp -= @damage
    lose?
  end

  def defend_stance(status)
    @defend = status == :on ? true : false
  end

  def receive_heal
    @heal = rand(1..10) * 3
    (@curr_hp + @heal > @max_hp) ? (@curr_hp = @max_hp) : (@curr_hp += @heal)
  end

private

  def lose?
    if @curr_hp <= 0
      @loser = true
    end
  end

end

class Command
  attr_reader :player1, :player2, :turn

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn = player1
  end

  def attack(target)
    target.receive_damage
    #change_turn
  end

  def change_turn
    @turn == player1 ? @turn = player2 : @turn = player1
    "#{@turn}, your turn!"
  end

end

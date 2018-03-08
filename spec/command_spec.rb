require 'command.rb'

describe Command do
  subject(:command) { described_class.new(ren, zan) }
  let(:ren) { double :ren, name: 'Renzokuken', max_hp: 100, curr_hp: 100 }
  let(:zan) { double :ren, name: 'Zantetsuken', max_hp: 100, curr_hp: 100 }

  describe "accepts two player instances" do
    it "and knows who Player 1 is" do
      expect(command.player1.name).to eq 'Renzokuken'
    end

    it "and knows who Player 2 is" do
      expect(command.player2.name).to eq 'Zantetsuken'
    end

    it "and knows the player's max HP" do
      expect(command.player1.max_hp).to eq 100
    end

    it "and knows the player's current HP" do
      expect(command.player1.curr_hp).to eq 100
    end

  end

  describe "reduces target's HP" do
    it "by a pre-defined amount (10) when attacked" do
      expect(zan).to receive(:receive_damage)
      command.attack(zan)
    end
  end

  describe "controls turns" do
    it "by changing player turns" do
      expect { command.change_turn }.to change { command.turn }.from(ren).to(zan)
    end
  end
end

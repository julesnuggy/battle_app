require 'command.rb'

describe Command do
  subject(:command) { described_class.new(jules, zan) }
  let(:jules) { double :jules, name: 'Jules', max_hp: 100, curr_hp: 100 }
  let(:zan) { double :jules, name: 'Zan', max_hp: 100, curr_hp: 100 }

  describe "accepts two player instances" do
    it "and knows who Player 1 is" do
      expect(command.player1.name).to eq 'Jules'
    end

    it "and knows who Player 2 is" do
      expect(command.player2.name).to eq 'Zan'
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
end

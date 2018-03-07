require 'player.rb'

describe Player do
  subject(:player) { described_class.new ('Jules Nuggy') }
  subject(:zan) { described_class.new('Zantetsuken') }
  let(:command_class) { double :command_class }
  let(:command) { double :command, target: zan }

    describe "provides details on the player" do
      it "knows the player's name" do
        expect(player.name).to eq "Jules Nuggy"
      end

      it "knows the player's max HP" do
        expect(player.max_hp).to eq 100
      end

      it "knows the player's current HP" do
        expect(player.curr_hp).to eq 100
      end

    end

end

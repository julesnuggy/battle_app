require 'battle_app'

describe Battle do

  feature "setting up a game" do
    before do
      visit '/'
    end

    scenario "displays a title message upon loading" do
      expect(page).to have_content 'WELCOME TO FINAL FANTASY CLASH'
    end

    scenario "allows user to start a new game" do
      click_link 'new_game'
    end

    scenario "allows users to complete a form to enter their names" do
      visit '/start-new-game'
      fill_in 'player1_name', with: 'Jules Nuggy'
      fill_in 'player2_name', with: 'Zantetsuken'
      click_button 'Continue'
      expect(page).to have_content "PREPARE FOR THE NEXT BATTLE! Jules Nuggy VS Zantetsuken"
    end
  end # feature setting up a game

  feature "checking player statuses" do
    before do
      sign_in_and_play
    end

    scenario "tells player 1 it's their turn" do
      expect(page).to have_content("MATCH Jules Nuggy, your turn...")
    end

    scenario "shows us P1 HP" do
      expect(page).to have_content("Jules Nuggy: 100/100")
    end

    scenario "shows us P2 HP" do
      expect(page).to have_content("Zantetsuken: 100/100")
    end

=begin
    scenario "allows player 1 to view player 2 HP" do
      #within("//section[@id='#p1_command_bar']") { click_button('p1_mag_scan') }
      p find_by_id("battle_message_text").text
      p click_on('p1_mag_scan')
      #expect(page).to have_content("MATCH Zantetsuken HP: 100")
      p find_by_id("battle_message_text").text
      expect("//p#'battle_message_text'").to have_content("Zantetsuken HP: 100")
    end
=end
  end # feature checking player statuses
end

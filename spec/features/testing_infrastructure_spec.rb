require 'battle_app'

describe Battle do
  before do
    visit '/'
  end

  feature "homepage" do
    scenario "displays a title message upon loading" do
      expect(page).to have_content 'WELCOME TO FINAL FANTASY VS'
    end

    scenario "allows user to start a new game" do
      click_link 'new_game'
    end

    scenario "allows users to complete a form to enter their names" do
      visit '/start-new-game'
      fill_in 'player1_name', with: 'Jules Nuggy'
      fill_in 'player2_name', with: 'Zantetsuken'
      click_button 'Submit Names'
      expect(page).to have_content 'PREPARE FOR THE NEXT BATTLE! Jules Nuggy VS Zantetsuken'
    end
  end

end

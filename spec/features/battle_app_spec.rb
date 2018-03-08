require '~/Documents/Coding/MA/battle/battle_app.rb'

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
      expect(page).to have_content("MATCH FIGHT")
    end

    scenario "shows us P1 HP" do
      expect(page).to have_content("Jules Nuggy: 100/100")
    end

    scenario "shows us P2 HP" do
      expect(page).to have_content("Zantetsuken: 100/100")
    end

  end # feature checking player statuses

  feature "taking actions" do
    before do
      sign_in_and_play
    end

    scenario "shows HP when Scan is cast" do
      click_on 'p1_mag_scan'
      expect(page).to have_content('Scanned Zantetsuken - HP: 100/100')
    end

    scenario "returns a confirmation message when attacking" do
      click_on 'p1_atk'
      expect(page).to have_content('Jules Nuggy attacked Zantetsuken')
    end

    scenario "reduces P2's HP when attacked" do
      click_on 'p1_atk'
      click_on 'Continue'
      click_on 'Continue'
      expect(page).to have_content('Zantetsuken: 90/100')
    end

    scenario "shows updated HP when Scan is cast after an attack" do
      click_on 'p1_atk'
      click_on 'Continue'
      click_on 'Continue'
      click_on 'p1_mag_scan'
      expect(page).to have_content('Scanned Zantetsuken - HP: 90/100')
    end
  end # taking actions

  feature "taking turns" do
    before do
      sign_in_and_play
    end

    scenario "shows when its P1's turn" do
      expect(page).to have_xpath("//img[contains(@id,'p1_turn')]")
    end

    scenario "allows P2 to go after P1" do
      click_on 'p1_atk'
      click_on 'Continue'
      expect(page).to have_content('Zantetsuken, your turn!')
    end

    scenario "allows P1 to go after P2" do
      click_on 'p1_atk'
      click_on 'Continue'
      click_on 'Continue'
      click_on 'p1_atk'
      click_on 'Continue'
      expect(page).to have_content('Jules Nuggy, your turn!')
    end

    scenario "shows when its P2's turn" do
      click_on 'p1_atk'
      click_on 'Continue'
      click_on 'Continue'
      expect(page).to have_xpath("//img[contains(@id,'p2_turn')]")
    end

  end
end

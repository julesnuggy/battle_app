require '~/Documents/Coding/MA/battle/battle_app.rb'

describe Battle do

  feature "setting up a game" do
    before do
      visit '/'
    end

    scenario "displays a title message upon loading" do
      expect(page).to have_content 'Heavenly Strike'
    end

    scenario "allows users to complete a form to enter their names" do
      fill_in 'player1_name', with: 'Renzokuken'
      fill_in 'player2_name', with: 'Zantetsuken'
      click_on 'submit_names'
      expect(page).to have_content "Heavenly Strike Renzokuken VS Zantetsuken"
    end
  end # feature setting up a game

  feature "checking start up" do
    before do
      sign_in_and_play
    end

    scenario "shows P1 name" do
      expect(page).to have_content('Renzokuken')
    end

    scenario "shows P2 name" do
      expect(page).to have_content('Zantetsuken')
    end

    scenario "shows battle message" do
      expect(page).to have_content('FIGHT!')
    end

  end # feature checking player statuses

  feature "taking actions" do
    before do
      sign_in_and_play
    end

    context "as Player 1" do
      scenario "shows HP when Scan is cast" do
        click_on 'p1_wmg_scan'
        expect(page).to have_content('Renzokuken cast SCAN... Zantetsuken - HP: 100/100')
      end

      scenario "returns a confirmation message when attacking" do
        click_on 'p1_atk'
        expect(page).to have_content('Renzokuken attacked Zantetsuken')
      end

      scenario "shows updated (reduced) HP when Scan is cast after an attack" do
        p1_completes_atk
        p2_completes_def
        click_on 'p1_wmg_scan'
        expect(page).not_to have_content('Renzokuken cast SCAN... Zantetsuken - HP: 100/100')
      end

      scenario "can defend against an attack" do
        click_on 'p1_def'
        expect(page).to have_content('Renzokuken defended')
      end

      scenario "can target self" do
        click_on 'p1_tgt_self'
        expect(page).to have_content('Targetting Renzokuken')
      end

      scenario "can target opponent" do
        click_on 'p1_tgt_opp'
        expect(page).to have_content('Targetting Zantetsuken')
      end

      scenario "can cast heal" do
        click_on 'p1_wmg_cure'
        expect(page).to have_content('Renzokuken cast CURE')
      end

      scenario "can cast fire magic" do
        click_on 'p1_bmg_fire'
        expect(page).to have_content('Renzokuken cast FIRE')
      end

      scenario "can cast ice magic" do
        click_on 'p1_bmg_ice'
        expect(page).to have_content('Renzokuken cast ICE')
      end
    end

    context "as Player 2" do
      before do
        p1_completes_def
      end

      scenario "shows HP when Scan is cast" do
        click_on 'p2_wmg_scan'
        expect(page).to have_content('Zantetsuken cast SCAN... Renzokuken - HP: 100/100')
      end

      scenario "returns a confirmation message when attacking" do
        click_on 'p2_atk'
        expect(page).to have_content('Zantetsuken attacked Renzokuken')
      end

      scenario "shows updated (reduced) HP when Scan is cast after an attack" do
        p2_completes_atk
        p1_completes_def
        click_on 'p2_wmg_scan'
        expect(page).not_to have_content('Zantetsuken cast SCAN... Renzokuken - HP: 100/100')
      end

      scenario "can defend against an attack" do
        click_on 'p2_def'
        expect(page).to have_content('Zantetsuken defended')
      end

      scenario "can target self" do
        click_on 'p2_tgt_self'
        expect(page).to have_content('Targetting Zantetsuken')
      end

      scenario "can target opponent" do
        click_on 'p2_tgt_opp'
        expect(page).to have_content('Targetting Renzokuken')
      end

      scenario "can use recover" do
        click_on 'p2_teq_recov'
        expect(page).to have_content('Zantetsuken used RECOVER')
      end

      scenario "can use true thrust" do
        click_on 'p2_teq_tr_thr'
        expect(page).to have_content('Zantetsuken used TRUE_THRUST')
      end

      scenario "can use jump" do
        click_on 'p2_teq_jump'
        expect(page).to have_content('Zantetsuken used JUMP')
      end
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
      click_on 'message_ok'
      expect(page).to have_content('Zantetsuken, your turn!')
    end

    scenario "allows P1 to go after P2" do
      p1_completes_atk
      click_on 'p2_atk'
      click_on 'message_ok'
      expect(page).to have_content('Renzokuken, your turn!')
    end

    scenario "shows when its P2's turn" do
      p1_completes_atk
      expect(page).to have_xpath("//img[contains(@id,'p2_turn')]")
    end
  end # taking turns

  feature "winning and losing" do
    before do
      sign_in_and_play
    end

    scenario "the game ends when Player 2's HP reaches 0" do
      9.times { p1_atk_p2_def }
      click_on 'p1_atk'
      expect(page).to have_content('Renzokuken wins!')
    end

    scenario "the game ends when Player 1's HP reaches 0" do
      9.times { p2_atk_p1_def }
      p1_completes_atk
      click_on 'p2_atk'
      expect(page).to have_content('Zantetsuken wins!')
    end

  end # winning and losing

  feature "playing against COMP" do
    before do
      play_vs_comp
    end

    scenario "the COMP takes its own actions" do
      click_on 'p1_atk'
      click_on 'message_ok'
      expect(page).to have_content('COMP: ')
    end

  end # playing against COMP

end

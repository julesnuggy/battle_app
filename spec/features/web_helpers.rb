def sign_in_and_play
  visit '/'
  click_link 'new_game'
  fill_in 'player1_name', with: 'Jules Nuggy'
  fill_in 'player2_name', with: 'Zantetsuken'
  click_button 'Continue'
  click_button 'Start Match'
end

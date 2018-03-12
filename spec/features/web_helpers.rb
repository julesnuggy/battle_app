def sign_in_and_play
  visit '/'
  fill_in 'player1_name', with: 'Renzokuken'
  fill_in 'player2_name', with: 'Zantetsuken'
  click_button 'Start New Game'
  click_button 'Start Match'
end

def play_vs_comp
  visit '/'
  fill_in 'player1_name', with: 'Renzokuken'
  fill_in 'player2_name', with: 'Computer'
  click_button 'Start New Game'
  click_button 'Start Match'
end

def p1_completes_atk
  click_on 'p1_atk'
  click_on 'message_ok'
end

def p2_completes_atk
  click_on 'p2_atk'
  click_on 'message_ok'
end

def p1_completes_def
  click_on 'p1_def'
  click_on 'message_ok'
end

def p2_completes_def
  click_on 'p2_def'
  click_on 'message_ok'
end

def p1_atk_p2_def
  click_on 'p1_atk'
  click_on 'message_ok'
  click_on 'p2_def'
  click_on 'message_ok'
end

def p2_atk_p1_def
  click_on 'p1_def'
  click_on 'message_ok'
  click_on 'p2_atk'
  click_on 'message_ok'
end

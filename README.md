# Heavenly Strike

## Introduction
**Heavenly Strike** is a simple web game app where contestants fight to defeat their opponent. The design (functional and aesthetic) was heavily influenced by the popoular Final Fantasy role playing game (RPG) series.

The game was developed using Ruby for the backend (client-side) logic together with the Sinatra web framework. HTML and CSS were used for the frontend (server-side) design of the game.

## How to Play
1. Players must first enter their names to start the game.
2. Player 1 is a Mage and Player 2 is a Dragoon - both have physical attack, special attack, defense, and healing abilities.
3. Player's take turns to select their action.
4. The amount of damage and healing done is randomised.
5. The first player to have their health points (HP) reduced to zero loses.

## Approach
As this was one of the week challenges at Makers Academy, I had a basic guide to introduce me to the concepts, technologies and order in which features should be implemented. A test-driven development approach using RSpec (unit tests) and Capybara (feature tests) was taken. After a certain point, I diverged from the guide to implement my own style and theme to the game - I drew inspiration from the Final Fantasy role playing game series' battle style.

## Installation
1. Clone this repo: `git clone https://github.com/julesnuggy/battle_app.git`
2. Install Bundler `gem install bundler`
3. Install this project's gems: `bundle install`
4. Run the local server: `ruby battle_app.rb`
5. In your browser, open the localhost to play the game: http://localhost:4567

## Testing
Both unit and feature tests are run using: `rspec`

## Improvements
This game was made during the 3rd week of Makers Academy, so my programming skills and knowledge were still relatively new then. There is much room for improvement in the structure of the code and the routing used.

There are only two classes to run the entire game, so SRP is definitely not as fully implemented as it could be.

There is a lot of reliance on the Sinatra file (battle_app.rb) to drive the game so it's very convoluted. JavaScript and jQuery could help handle a lot of this to reduce the amount of page refreshing and (re)directing.

A future feature would be to allow players to choose different classes but that quickly became too difficult to implement within the timeframe. Different classes would have had different statstics (attack, defence, etc).

Certain features are currently moot - such as displaying both player's HP on the screen when there is a Scan command to find out how much health your opponent has. These small bugs/obsolete features need to be addressed.

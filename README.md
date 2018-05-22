# Heavenly Strike

## Introduction
**Heavenly Strike** is a simple web game app where contestants fight to defeat their opponent. The design (functional and aesthetic) was heavily influenced by the popoular Final Fantasy role playing game (RPG) series.

The game was developed using Ruby for the backend (client-side) logic together with the Sinatra web framework. HTML and CSS were used for the frontend (server-side) design of the game.

## How to Play
Players must first enter their names to start the game.

Player 1 is a Mage and Player 2 is a Dragoon - both have physical attack, special attack, and healing abilities.

The amount of damage and healing done is randomised.

The first player to have their health points (HP) reduced to zero loses.

## Approach

## Installation

## Testing

## Improvements
This game was made during the 3rd week of Makers Academy, so my programming skills and knowledge were still relatively new then. There is much room for improvement in the structure of the code and the routing used.

There are only two classes to run the entire game, so SRP is definitely not as fully implemented as it could be.

There is a lot of reliance on the Sinatra file (battle_app.rb) to drive the game so it's very convoluted. JavaScript and jQuery could help handle a lot of this to reduce the amount of page refreshing and (re)directing.

A future feature would be to allow players to choose different classes but that quickly became too difficult to implement within the timeframe. Different classes would have had different statstics (attack, defence, etc).

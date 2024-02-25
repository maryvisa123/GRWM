# GRWM

Welcome to `GRWM`! This is a fast-paced, casual game where you help Sally prepare for her job interview. With only 60 seconds on the clock, you need to help her get ready. You'll need to choose between getting her makeup done, outfit sorted, hair styled, and files ready. You won't have enough time to get everything done, so make your choices wisely. You can watch a demo of this game [here](https://youtu.be/5qtWPs5PL84).

## Game Objective

Sally is about to have an important job interview, but there's a problem - she overslept! The player has to help Sally get ready for her interview within 60 seconds. The player will have to control a tote bag and catch the falling items necessary for the preparation for Sally's job interview.

The items correspond to four different tasks:

1. Makeup
2. Outfit
3. Hairstyle
4. Interview files

The player has to choose wisely, as not everything can be done in 60 seconds!

## How To Play

You control Sally's tote bag. Your job is to catch falling items which correspond to four different preparation tasks. Each item you catch helps Sally to prepare for her interview and will increase your score.

Each task you perform increases the corresponding score. However, there's a catch! If you neglect any task too much, it might affect Sally's readiness negatively.

## Installation

1. Install [LÖVE](https://love2d.org/) from the official website. Our game requires LÖVE 11.3 or newer.
2. Download the .love file of our game and run it with the LÖVE interpreter.

## Controls

- Move the tote bag by moving your mouse.
- Press 'Space' key or left click to proceed with the dialogues.
- At the end of the game, click on 'Restart' or 'Quit' as per your preference.

## Game Over

The game ends when the timer reaches 0. At the end, Sally's readiness for each task is calculated and you get feedback on your performance. The feedback depends on your score for each task.

## File Structure

The project contains the following main Lua scripts:

- `main.lua`: The entry point of the game. Handles the game states and switching between them.
- `dialogue.lua`: Manages the dialogue system of the game.
- `game.lua`: Manages the gameplay logic, including items generation and scoring system.
- `gameover.lua`: Handles the game over screen, showing the results and feedback.

## main.lua

### Loading Assets

- The script loads various game assets including fonts, images, and audio files required for the game.

### Game State Control

- The `love.update` function is responsible for updating the game logic based on the current game state.
- The game state can be one of the following:
  - "start": Displays the start screen.
  - "dialogue": Handles the dialogue sequence between characters.
  - "gameplay": Controls the main gameplay.
  - "gameover": Shows the game over screen.

### Start Screen

- The start screen is displayed when the game state is set to "start".
- It shows the game title and a start button.
- The start button triggers a transition to the dialogue state when clicked.

### Dialogue

- The dialogue state (`gameState == "dialogue"`) handles the conversation between characters.
- The `Dialogue.update` function is called to update the dialogue state.
- The `Dialogue.isFinished` function checks if the dialogue is finished.
- Once the dialogue is finished, the game state transitions to "gameplay".
- Background image and background music are changed when transitioning to the dialogue state.

### Gameplay

- The gameplay state (`gameState == "gameplay"`) controls the main gameplay loop.
- The `Game.update` function is called to update the gameplay logic.
- The `Game.isOver` function checks if the game is over.
- When the game is over, the game state transitions to "gameover".
- Background music is changed when transitioning to the gameplay state.

### Game Over Screen

- The game over screen is displayed when the game state is set to "gameover".
- The `GameOver.draw` function is called to draw the game over screen.
- The function takes the game scores as input to display them.
- The game over screen provides options to restart the game or quit.

### Input Handling

- The `love.keypressed` function handles key press events when the game state is "dialogue".
- The `love.mousepressed` function handles mouse click events based on the current game state.
- In the start state, clicking the start button transitions to the dialogue state.
- In the game over state, clicking the restart button restarts the game, and clicking the quit button quits the game.

## Sounds and Graphics

All graphics and sounds in this game are under a license that allows us to use them freely.

Have fun playing Interview in 60 Seconds!

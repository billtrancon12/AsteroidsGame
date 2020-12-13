Version 1
This version is functionally complete but has not been refactored for levels. 

Version 2
This version has been refactored for levels and other improvements.

Version 3
This version was refactored to include multiple game levels, start, win, lose levels. 
A state machine to handle level transitions. 
Refactoring of GameObjects to simplify design.

*Instructions:
-Press arrows to move
-Press SPACE to shoot
-Press P to pause and unpause the game

*At the end of the game (either losing level and winning level):
-Press Y to restart the game
-Press N to exit the game

*The support items in the game will be floating throught out the game and only last for 60 seconds. 
*If player touches the items, in other words using them, the items will only last for 10 seconds. There will be a timer for duration.
Notice the pausing mechanics will not affect the duration of the items.
*The shield items and speed boosts will not have a special visual effect, but the player has the timer to determine the duration of the items.
*The pausing mechanic is still flawed, especially ship's movement.

*Score System:
-When player destroys a big asteroid, he/she gains 50 points. Destroying a small one will gain him/her 10 points.
-It applies the same amount of points when a player collapses with the asteroids. Collapsing a big one will cost a player 50 points, and 
a small one will cost 10 points.
-Bonus score will be calculated based on the amount of lives the player has left at the end of the game. 10 bonus points for each life.
-The level score will be calculated independently in each level, then sum up at the end of the level.
-The total score and the bonus score will be displayed at the end of the level (either losing or winning the game)

ENJOY THE REMIXED GAME BY TEAM 14!
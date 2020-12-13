
import sprites.*;
import sprites.utils.*;
import sprites.maths.*;
import java.util.*;
import java.util.concurrent.*;

GameLevel gameLevel;
PImage background;

KeyboardController kbController;
SoundPlayer soundPlayer;
StopWatch stopWatch = new StopWatch();
MenuButton menuButton;
ScoreTracker scoreTracker;
FileHelper fileHelper;

boolean muted;
int level = 1;
String path;
String user;
int current_score = 0;
boolean restart = false;

void setup() 
{
  size(1000, 700);
  background = loadImage("bg.jpg");
  kbController = new KeyboardController(this);
  soundPlayer = new SoundPlayer(this);
  
  path = System.getProperty("user.dir");
  scoreTracker = new ScoreTracker();

  scoreTracker.setup();
  

  // register the function (pre) that will be called
  // by Processing before the draw() function. 
  registerMethod("pre", this);

  gameLevel = new StartLevel(this, scoreTracker);
  gameLevel.start();
}

// Executed before each next frame is drawn. 
void pre() 
{
  gameLevel.update();
  nextLevelStateMachine();
}

// Determine the next GameLevel to play
void nextLevelStateMachine()
{
  GameState state = gameLevel.getGameState();
  fileHelper = new FileHelper(System.getProperty("user.dir"));
  
  int current_lives = gameLevel.getNumLives();
  int total_score = gameLevel.getTotalScore();
  this.restart = gameLevel.isRestart();
  
  if (gameLevel instanceof StartLevel) {
    this.user = gameLevel.getUser();
    if (state == GameState.Finished) {
      muted = gameLevel.getVoiceState();
      menuButton = gameLevel.menuButton;
      gameLevel.stop();
      gameLevel = new AsteroidsLevelSystem(this, level, 3, muted, menuButton, current_score, 0);
      gameLevel.start();
    }
  }

   else if(gameLevel instanceof AsteroidsLevelSystem && level < 3){
     if(state == GameState.Finished){ 
        gameLevel.stop();
        level += 1;
        gameLevel = new AsteroidsLevelSystem(this, level, current_lives, muted, menuButton, current_score, total_score);
        gameLevel.start();
     }
     else if(state == GameState.Lost){
        gameLevel.stop();
        
        this.scoreTracker.updateScore(user, total_score);  
        fileHelper.writeFile(this.user + " " + (total_score + current_lives * 10), path + "\\user\\" + this.user + ".txt"); 
        
        gameLevel = new LoseLevel(this, this.muted, total_score, current_lives);
        gameLevel.start();
     }
  }
  else if(gameLevel instanceof AsteroidsLevelSystem && level == 3){
    if(state == GameState.Finished){
        gameLevel.stop();
        
        this.scoreTracker.updateScore(user, total_score);  
        this.fileHelper.writeFile(this.user + " " + (total_score + current_lives * 10), path + "\\user\\" + this.user + ".txt"); 

        gameLevel = new WinLevel(this, this.muted, total_score, current_lives);
        gameLevel.start();
    }
    else if(state == GameState.Lost){
        gameLevel.stop();
        
        this.scoreTracker.updateScore(user, total_score);  
        fileHelper.writeFile(this.user + " " + (total_score + current_lives * 10), path + "\\user\\" + this.user + ".txt");       
      
        gameLevel = new LoseLevel(this, this.muted, total_score, current_lives);
        gameLevel.start();
    }
  }
  else if(gameLevel instanceof RestartLevel){
    if(state == GameState.NotRunning){
      exit();    
    }
    else if (state == GameState.Restart){
      gameLevel.stop();
      this.level = 1;
      this.current_score = 0;
      gameLevel = new AsteroidsLevelSystem(this, level, 3, muted, menuButton, current_score, 0);
      gameLevel.start();
    }
  }
  else if(state == GameState.NotRunning && ((!gameLevel.isPlay() && !muted) || !gameLevel.isTriggered())){
    gameLevel.stop();
    gameLevel = new RestartLevel(this);  
    gameLevel.start();
  }
}

void keyPressed() 
{
  gameLevel.keyPressed();
}

void draw() 
{
  // Background image must be same size as window. 
  background(background);

  S4P.updateSprites(stopWatch.getElapsedTime());

  S4P.drawSprites();
  gameLevel.drawOnScreen();
}


public enum GameState
{
  NotRunning, 
    Running, 
    Finished,
    Pause,
    Lost,
    Win,
    Restart;
}

/***********************************************/


abstract class GameLevel 
{
  PApplet applet;
  GameState gameState; 
  MenuButton menuButton;
  boolean restart = false;
  
  GameLevel(PApplet applet)
  {
    this.applet = applet;
    gameState = GameState.NotRunning;
  }

  // Initialize all the resources needed by the level
  abstract void start();

  // Deallocate the resources maintained by the level
  abstract void stop();

  // Reinitialize the resources maintained by the level.
  abstract void restart();

  // Called every frame to update the resources maintained by the level.
  abstract void update();
  
  //Called every frame to update the number of lives the ship has
  abstract int getNumLives();
  abstract int getCurrentScore();
  abstract int getTotalScore();
  
  public boolean isRestart(){return this.restart;}
  public boolean isPlay(){return true;}
  public String getUser(){return null;}
  abstract boolean isTriggered();

  abstract GameState getGameState();

  // Use raw Processing operations to draw on the screen.
  abstract void drawOnScreen();

  // Called when a key is pressed in the active level. 
  abstract void keyPressed();
  abstract boolean getVoiceState();
}


/*********************************************/


class StartLevel extends GameLevel
{
  StartButton startButton;
  LeaderBoardButton leaderboardButton;
  ScoreTracker scoreTracker;
  
  int isEntered;
  String user;
  List<String> input;
  
  StartLevel(PApplet applet, ScoreTracker scoreTracker)
  {
    super(applet);
    isEntered = 0;
    this.scoreTracker = scoreTracker;
    input = new ArrayList<String>();
    gameState = GameState.NotRunning;
  }

  void start()
  { 
    startButton = new StartButton(applet, width / 2, height / 2, this);
    leaderboardButton = new LeaderBoardButton(applet, 970,670, scoreTracker);
    
    gameState = GameState.Running;
  }

  void stop()
  {
    startButton.setDead();
    menuButton.setDead();
    if(menuButton.settingButton != null) {
      menuButton.settingButton.setDead();
      if(menuButton.settingButton.musicButton != null) menuButton.settingButton.musicButton.setDead();
    }
    if(menuButton.helpButton != null) menuButton.helpButton.setDead();
    leaderboardButton.setDead();
  }

  void restart()
  {
  }
  
  public boolean getVoiceState(){ 
   if(this.menuButton.settingButton == null || this.menuButton.settingButton.musicButton == null)
     return false;
    return this.menuButton.settingButton.musicButton.muted; 
  }

  void update()
  {
    if(menuButton != null){ 
      if(menuButton.settingButton != null){
        menuButton.helpButton.update();
        menuButton.settingButton.update();
        //if(!menuButton.settingButton.active){
          if(menuButton.settingButton.ypos <= 75)
            menuButton.settingButton.setDead();
          if(menuButton.helpButton.ypos <= 75)
            menuButton.helpButton.setDead();
        //}
      }
    } 
    if(menuButton == null && isEntered == 1){
      menuButton = new MenuButton(applet, 970, 30);
    }
  }
  
  boolean isTriggered(){
    return true;  
  }

  GameState getGameState()
  {
    return gameState;
  }

  void drawOnScreen()
  {
    switch(isEntered){
      case(0):
        fill(255);
        rect(100, height / 2 - 30,800,55);
        fill(0);
        textSize(35);
        text("Enter you name: ", 100, height / 2 + 10);
        fill(255,0,0);
        text("The name can be at most 20 characters long", 100, height / 2 + 60);
        String name = "";
        StringBuilder strBuilder = new StringBuilder();
        for(int i = 0; i < input.size(); i ++){
          strBuilder.append(input.get(i));  
        }
        name = strBuilder.toString();
        this.user = name;
        fill(0);
        text(name, 380, height / 2 + 10);
        break;
      case(1):
        if(menuButton.helpButton == null ||menuButton.helpButton.instruction == null || menuButton.helpButton.instruction.isDead()){
            FileHelper fileHelper = new FileHelper(System.getProperty("user.dir"));
            fileHelper.createFile(this.user+".txt","user");
            fill(255);
            text("Welcome " + this.user, (width - textWidth("Welcome " + this.user)) / 2, height / 2 - 60);
            startButton.isClickable(1);
            break;
        }
    }
    
    leaderboardButton.drawOnScreen();
  }
  
  String getUser(){
    return this.user;  
  }

  void keyPressed()
  {
    if ((key==ENTER||key==RETURN) && input.size() > 0) {
      isEntered = 1;
    }
    if(input.size() <= 20 && !leaderboardButton.isLeaderBoard){
      if(key == 'a'){
        input.add("a");   
      }
      if(key == 'A'){
        input.add("A");   
      }
      if(key == 'b'){
        input.add("b");   
      }
      if(key == 'B'){
        input.add("B");   
      }
      if(key == 'c'){
        input.add("c");   
      }
      if(key == 'C'){
        input.add("C");   
      }
      if(key == 'd'){
        input.add("d");   
      }
      if(key == 'D'){
        input.add("D");   
      }
      if(key == 'e'){
        input.add("e");   
      }
      if(key == 'E'){
        input.add("E");   
      }
      if(key == 'f'){
        input.add("f");   
      }
      if(key == 'F'){
        input.add("F");   
      }
      if(key == 'g'){
        input.add("g");   
      }
      if(key == 'G'){
        input.add("G");   
      }
      if(key == 'h'){
        input.add("h");   
      }
      if(key == 'H'){
        input.add("H");   
      }
      if(key == 'i'){
        input.add("i");   
      }
      if(key == 'I'){
        input.add("I");   
      }
      if(key == 'j'){
        input.add("j");   
      }
      if(key == 'J'){
        input.add("J");   
      }
      if(key == 'k'){
        input.add("k");   
      }
      if(key == 'K'){
        input.add("K");   
      }
      if(key == 'l'){
        input.add("l");   
      }
      if(key == 'L'){
        input.add("L");   
      }
      if(key == 'm'){
        input.add("m");   
      }
      if(key == 'M'){
        input.add("M");   
      }
      if(key == 'n'){
        input.add("n");   
      }
      if(key == 'N'){
        input.add("N");
      }
      if(key == 'o'){
        input.add("o");   
      }
      if(key == 'O'){
        input.add("O");   
      }
      if(key == 'p'){
        input.add("p");   
      }
      if(key == 'P'){
        input.add("P");   
      }
      if(key == 'q'){
        input.add("q");   
      }    
      if(key == 'Q'){
        input.add("Q");   
      }
      if(key == 'r'){
        input.add("r");   
      }
      if(key == 'R'){
        input.add("R");   
      }
      if(key == 's'){
        input.add("s");   
      }
      if(key == 'S'){
        input.add("S");   
      }
      if(key == 't'){
        input.add("t");   
      }
      if(key == 'T'){
        input.add("T");   
      }
      if(key == 'v'){
        input.add("v");
      }
      if(key == 'V'){
        input.add("V");
      }
      if(key == 'u'){
        input.add("u");   
      }
      if(key == 'U'){
        input.add("U");   
      }
      if(key == 'w'){
        input.add("w");   
      }
      if(key == 'W'){
        input.add("W");   
      }
      if(key == 'x'){
        input.add("x");   
      }
      if(key == 'X'){
        input.add("X");   
      }
      if(key == 'y'){
        input.add("y");   
      }
      if(key == 'Y'){
        input.add("Y");   
      }
      if(key == 'z'){
        input.add("z");   
      }
      if(key == 'Z'){
        input.add("Z");   
      }
      if(key == ' '){
        input.add(" ");  
      }
    }
    if(key == BACKSPACE && !leaderboardButton.isLeaderBoard){
      if(input.size() > 0)
        input.remove(input.size() - 1);  
      }
  }
  
  //Implemented, not used
  int getNumLives(){
    return 0;  
  }
  
  //Implemented, not used
  int getCurrentScore(){return 0;}
  
  //Implemented, not used
  int getTotalScore(){return 0;}
}

/*********************************************/


class LoseLevel extends GameLevel
{
  GameOver gameOver;
  boolean muted;
  int score;
  int bonusScore;
  long triggerTime;

  LoseLevel(PApplet applet, boolean muted, int score, int bonus)
  {
    super(applet);
    this.muted = muted;
    this.score = score;
    this.bonusScore = bonus;
  }

  void start()
  {
    gameOver = new GameOver(applet, width/2, height/2);
    gameOver.trigger();
    triggerTime = System.currentTimeMillis();
    soundPlayer.gameOverPlayer = soundPlayer.minimplay.loadFile("ThatsAllFolks.wav", 1024);
    
    
    if(!this.muted)
      soundPlayer.playGameOver();
    
    gameState = GameState.Running;
  }

  void stop()
  {
    gameOver.setDead();
  }

  boolean isPlay(){
    return soundPlayer.gameOverPlayer.isPlaying(); 
  }

  void restart()
  {
  }

  void update()
  {
    gameOver.update();
    isTriggered();
  }
  
  public boolean getVoiceState(){
     return true; 
  }
  
  boolean isTriggered(){
    // Stop animation when sound ends.
    long current_time = System.currentTimeMillis();
    if((current_time - triggerTime) < soundPlayer.gameOverPlayer.length()){
      return true;  
    }
    else{
       return false; 
    }
  }

  GameState getGameState()
  {
    return GameState.NotRunning;
  }

  void drawOnScreen(){
     
     String msg = "Score: " + this.score;
     text(msg,10,40);
     msg = "Bonus Score: " + (this.bonusScore-1); //we subtract 1 since there will be no lives left after you die, so you the bonus score on lose level should be 0.
     text(msg,10,60);
     msg = "Total Score: " + (this.score); 
     text(msg,10,80);
  }

  void keyPressed()
  {
    if((key == 'R' || key == 'r') && !restart){
      this.restart = true;  
    }
  }
  
  //Implemented, not used
  int getNumLives(){
     return 0; 
  }

  //Implemented, not used
  int getCurrentScore(){return 0;}
  
  //Implemented, not used
  int getTotalScore(){return 0;}
}

/*********************************************/


class WinLevel extends GameLevel
{
  OhYea ohYea;
  Ship ship;
  float scale = 0;
  float scaleInc = .05;
  long triggerTime;
  boolean muted;
  int bonusScore;
  int score;

  WinLevel(PApplet applet, boolean muted, int score, int bonus)
  {
    super(applet);
    this.muted = muted;
    this.score = score;
    this.bonusScore = bonus;
  }

  void start()
  {
    triggerTime = System.currentTimeMillis();
    soundPlayer.ohYea = soundPlayer.minimplay.loadFile("OhYea.wav", 1024);
    
    if(!this.muted){
      soundPlayer.playOhYea();
    }


    ohYea = new OhYea(applet, width/2, height/2);
    ohYea.trigger();

    ship = new Ship(applet, width/2, height/2);

    gameState = GameState.Running;
  }

  void stop()
  {
    ohYea.setDead();
    ship.setDead();
  }

  public boolean getVoiceState(){
     return true; 
  }
  
  void restart()
  {
  }
  
  boolean isPlay(){
    return soundPlayer.ohYea.isPlaying();  
  }
  
  boolean isTriggered(){
    // Stop animation when sound ends.
    long current_time = System.currentTimeMillis();
    if((current_time - triggerTime) < soundPlayer.ohYea.length()){
      return true;  
    }
    else{
       return false; 
    }
  }

  void update()
  {
    if (isTriggered()) {
      ohYea.update();
      
      // Manipulate the ship directly.
      scale += scaleInc;
      ship.sprite.setScale(abs(cos(scale)*1.5));
      ship.sprite.setX((cos(scale) * 100) + width/2);
      ship.sprite.setY((sin(scale) * 200) + height/2);
      ship.sprite.setRot((sin(scale) * PI));
    }
    else {
      ohYea.setDead();
      ship.setDead();
    }
  }

  GameState getGameState()
  {
    return GameState.NotRunning;
  }

  void drawOnScreen(){
     
     String msg = "Score: " + this.score;
     text(msg,10,40);
     msg = "Bonus Score: " + (this.bonusScore * 10); //we subtract 1 since there will be no lives left after you die, so you the bonus score on lose level should be 0.
     text(msg,10,60);
     msg = "Total Score: " + (this.score + this.bonusScore * 10); 
     text(msg,10,80);
  }
  
  void keyPressed()
  {

  }
  
  //Implemented, not used
  int getNumLives(){
     return 0;
  }
  
  //Implemented, not used
  int getCurrentScore(){return 0;}
  
  //Implemented, not used
  int getTotalScore(){return 0;}
}

class RestartLevel extends GameLevel{
  RestartLevel(PApplet applet)
  {
    super(applet);
    this.gameState = GameState.Running;
  }
    
  void keyPressed(){
    if(key == 'y' || key == 'Y'){
      gameState = GameState.Restart;
    }
    else if (key == 'n' || key == 'N'){
      gameState = GameState.NotRunning;
    }
  }
  
  void update(){
    
  }
  void restart(){
  
  }
  void stop(){
    
  }
  
  void start(){
      
  }
  
  GameState getGameState()
  {
    return gameState;
  }
  
  //Implemented, not used
  int getNumLives(){
     return 0; 
  }

  //Implemented, not used
  int getCurrentScore(){return 0;}
  
  //Implemented, not used
  int getTotalScore(){return 0;}
  
  void drawOnScreen(){
    String msg;
    textSize(30);
    msg = "Do you want to restart?";
    text(msg, 365, 280);
    msg = "Y : restart";
    text(msg, 365, 340);
    msg = "N : exit";
    text(msg, 365, 400);
  }
  
  boolean getVoiceState(){
    return false;  
  }
  
  boolean isTriggered(){
    return true;  
  }
}

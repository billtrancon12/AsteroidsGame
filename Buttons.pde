

public abstract class Button extends GameObject
{
  public Sprite sprite;
  
  Button(PApplet applet, String imageFilename, int xpos, int ypos)
  {
    sprite = new Sprite(applet, imageFilename, 70);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(0.5);
  }
  
  void setDead() 
  {
    sprite.setDead(true);
    S4P.deregisterSprite(sprite);
  }
  
  abstract void isClickable(int state);
}


/*****************************************/


public class StartButton extends Button
{
  GameLevel level;
  boolean isClickable;
  
  StartButton(PApplet applet, int xpos, int ypos, GameLevel level)
  {
    super(applet, "Start_BTN.png", xpos, ypos);

    this.level = level;
    this.isClickable = false;
    sprite.respondToMouse(true);
    sprite.addEventHandler(this, "onPress");
  }
  
  public void onPress(Sprite sprite)
  {
    if(this.isClickable)
      level.gameState = GameState.Finished;
  }
  void update(){
  
  }
  
  void isClickable(int state){
    if(state == 1)
      this.isClickable = true;
  }
}

public class MenuButton extends Button
{
  String msg; 
  PApplet applet;
  long lastTouch;
  SettingButton settingButton;
  HelpButton helpButton;
  
  MenuButton(PApplet applet, int xpos, int ypos)
  {
    super(applet, "Menu_BTN.png", xpos, ypos);
    
    this.applet = applet;
    this.lastTouch = 0;
    
    //this.level = level;
    sprite.respondToMouse(true);
    sprite.setScale(0.25);
    sprite.addEventHandler(this, "onPress");
  }
  
  public void onPress(Sprite sprite)
  {
    //level.gameState = GameState.Finished;    
    long currentTouch = System.currentTimeMillis();
    if (currentTouch - lastTouch > 250 || lastTouch == 0){
      if(sprite.eventType == Sprite.PRESS){
        if(this.settingButton == null){
           this.settingButton = new SettingButton(applet, 970, 80);
           this.helpButton = new HelpButton(applet, 970, 75);
           this.settingButton.active = true;
           this.helpButton.active = true;
           return;
        }
        if(this.settingButton.sprite.isDead()){   
          this.settingButton.sprite = new Sprite(applet, "Settings_BTN.png", 80);
          this.settingButton.sprite.setScale(0.25);
          this.settingButton.sprite.respondToMouse(true);
          this.settingButton.sprite.addEventHandler(this.settingButton, "onPress");
   
          this.helpButton.sprite = new Sprite(applet, "Info_BTN.png", 80);
          this.helpButton.sprite.setScale(0.25);
          this.helpButton.sprite.respondToMouse(true);
          this.helpButton.sprite.addEventHandler(this.helpButton, "onPress");
        
          this.settingButton.active = true;
          this.helpButton.active = true;
      
        }
        else{
          this.settingButton.active = false;
          this.helpButton.active = false;
        
          if(this.settingButton.musicButton != null){
            this.settingButton.musicButton.sprite.setDead(true);
            S4P.deregisterSprite(this.settingButton.musicButton.sprite);
          }
        }
       }
      lastTouch = currentTouch;
      return;
    }
  }
  
  void update(){
    
    
  }
  
  void isClickable(int state){
    
  }
}

public class SettingButton extends Button
{
  PApplet applet;
  MusicButton musicButton;
  boolean active;
  int xpos;
  int ypos;
  
  SettingButton(PApplet applet, int xpos, int ypos)
  {
    super(applet, "Settings_BTN.png", xpos, ypos);
    
    this.applet = applet;
    this.xpos = xpos;
    this.ypos = ypos;
    //this.level = level;
    sprite.respondToMouse(true);
    sprite.setScale(0.25);
    sprite.addEventHandler(this, "onPress");
  }
  
  public void onPress(Sprite sprite)
  {
    if(this.sprite.eventType == Sprite.PRESS){
      if(musicButton == null){
         this.musicButton = new MusicButton(applet, 910, 90);
         return;
      }
      if(!this.musicButton.muted && this.musicButton.sprite.isDead()){
        this.musicButton.sprite = new Sprite(applet, "Music_BTN.png", 80);
        this.musicButton.sprite.setScale(0.25);
        this.musicButton.sprite.setXY(910, 90);
        this.musicButton.sprite.respondToMouse(true);
        this.musicButton.sprite.addEventHandler(this.musicButton, "onPress");
      }
      else if(this.musicButton.muted && this.musicButton.sprite.isDead()){
        this.musicButton.sprite = new Sprite(applet, "Music_Muted_BTN.png", 80);
        this.musicButton.sprite.setScale(0.25);
        this.musicButton.sprite.setXY(910, 90);
        this.musicButton.sprite.respondToMouse(true);
        this.musicButton.sprite.addEventHandler(this.musicButton, "onPress");
      }
      else if(!this.musicButton.sprite.isDead()){
        this.musicButton.sprite.setDead(true);
        S4P.deregisterSprite(this.musicButton.sprite);
      }
    }
  }
  
  void update(){
    if(active && ypos < 90){
      ypos += 3;
      sprite.setXY(xpos, ++ypos);
    }
    else if(!active && ypos > 75){
      ypos -=5;
      sprite.setXY(xpos, ypos);
    }
  }
  void isClickable(int state){
  }
}

public class HelpButton extends Button
{
  PApplet applet;
  Sprite instruction;
  int xpos;
  int ypos;
  boolean active;
  
  HelpButton(PApplet applet, int xpos, int ypos)
  {
    super(applet, "Info_BTN.png", xpos, ypos);
    
    this.applet = applet;
    this.xpos = xpos;
    this.ypos = ypos;
    //this.level = level;
    sprite.respondToMouse(true);
    sprite.setScale(0.25);
    sprite.addEventHandler(this, "onPress");
  }
  
  public void onPress(Sprite sprite)
  {
    if(sprite.eventType == Sprite.PRESS){
      if(instruction == null) {
        instruction = new Sprite(applet, "Instruction.png", 80);
        instruction.setScale(0.8);
        instruction.setXY(width / 2, height / 2);
      }
      else if(instruction.isDead()) {
        instruction = new Sprite(applet, "Instruction.png", 80);
        instruction.setScale(0.8);
        instruction.setXY(width / 2, height / 2);
      }  
      else{
        instruction.setDead(true);
        S4P.deregisterSprite(instruction);
      }
    }
    //level.gameState = GameState.Finished;    
  }
  void update(){
    if(active && ypos < 150){
      ypos += 5;
      sprite.setXY(xpos, ypos);
    }
    else if(!active && ypos > 75){
      ypos -= 5;
      sprite.setXY(xpos, ypos);
    }
  }
  
  void isClickable(int state){
    
  }
}

public class MusicButton extends Button
{
  PApplet applet;
  MusicButton musicButton;
  boolean muted;
  
  MusicButton(PApplet applet, int xpos, int ypos)
  {
    super(applet, "Music_BTN.png", xpos, ypos);
    
    this.applet = applet;
    this.muted = false;
    //this.level = level;
    sprite.respondToMouse(true);
    sprite.setScale(0.25);
    sprite.addEventHandler(this, "onPress");
  }
  
  public void onPress(Sprite sprite)
  {
    if(this.sprite.eventType == Sprite.PRESS){
      this.muted = !this.muted;
      return;
    }
  }
  
  void update(){
    
  }
  
  void isClickable(int state){
  
  }
}

public class LeaderBoardButton extends Button
{
  PApplet applet;
  ScoreTracker scoreTracker;
  boolean isLeaderBoard;
  
  LeaderBoardButton(PApplet applet, int xpos, int ypos, ScoreTracker scoreTracker)
  {
    super(applet, "Rating_BTN.png", xpos, ypos);
    this.scoreTracker = scoreTracker;
    this.applet = applet;
    this.isLeaderBoard = false;
    sprite.respondToMouse(true);
    sprite.setScale(0.25);
    sprite.addEventHandler(this, "onPress");
  }
  
  public void onPress(Sprite sprite)
  {
    if(this.sprite.eventType == Sprite.PRESS){
      this.isLeaderBoard = !this.isLeaderBoard;
    }
  }
  
  void drawOnScreen(){
      if(isLeaderBoard){
        //System.out.println(scoreTracker.leaderboard);
        fill(255);
        rect(100, 50, 800, 600);
        fill(0);
        text("LEADERBOARD", 390,120);
        int ypos = 170;
        int xpos = 160;
        textSize(35);
        for(Map.Entry<String, Integer> entry : scoreTracker.leaderboard.entrySet()){
          text(entry.getKey() + " " + entry.getValue(),xpos, ypos);
          ypos += 50;
        }      
      }    
  }
  void update(){
  }
  
  void isClickable(int state){

  }
}


//public class LogButton extends Button
//{
//  GameLevel level;
//  PrintWriter output;
  
//  LogButton(PApplet applet, int xpos, int ypos, GameLevel level)
//  {
//    super(applet, "Log Button.png", xpos, ypos);
//    sprite.setScale(0.4);

//    this.level = level;
//    sprite.respondToMouse(true);
//    sprite.addEventHandler(this, "onPress");
//  }
  
//  public void onPress(Sprite sprite)
//  {
//   output = createWriter("positions.txt");
//  }
//  void draw() {
//  point(mouseX, mouseY);
//  output.println(mouseX + "t" + mouseY); // Write the coordinate to the file
//  }

//  void keyPressed() {
//    output.flush(); // Writes the remaining data to the file
//    output.close(); // Finishes the file
//    exit(); // Stops the program
//  }
  
//  void update(){
    
//  }
//}

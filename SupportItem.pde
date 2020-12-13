class SupportItem extends GameObject{
   int speed = 30;
   float direction = random(0,2)*PI;
   long createdTime;
   SupportItem(PApplet applet, String ImageString, int xpos, int ypos){
     sprite = new Sprite(applet, ImageString, 1, 1, 20);
     sprite.setXY(xpos, ypos);
     sprite.setVelXY(0,0);
     sprite.setScale(0.5);
     sprite.setFrame(0);
     sprite.setSpeed(this.speed, direction);
     this.setSpeed(this.speed);
     this.setDirection(direction);
     
    // Domain keeps the moving sprite withing specific screen area 
    sprite.setDomain(0, 0, width, height, Sprite.REBOUND );
   }
   
   //Implemented, not used
   void update(){

   }
   
   void setDead(){
     super.setDead(); 
   }
   
}

class HealthIcon extends SupportItem
{  
  long createdTime;
  HealthIcon(PApplet applet, int xpos, int ypos) 
  {    
    super(applet, "HP_Icon.png", xpos, ypos);
    createdTime = System.currentTimeMillis();
  }
  
  void update(){
    long currentTime = System.currentTimeMillis();
    //Run the icon for 20 seconds
    if((currentTime - createdTime - this.getPauseDuration()) > 60000){
       this.sprite.setDead(true);
    }
  }

  void setDead()
  {
    super.setDead();
  }
}

class ArmorIcon extends SupportItem{
   long createdTime;
   
   ArmorIcon(PApplet applet, int xpos, int ypos){
      super(applet, "Armor_Icon.png", xpos, ypos);
      createdTime = System.currentTimeMillis();
   }
   
   void update(){
      if(this.getDuration() - this.getPauseDuration() > 60000){
         this.sprite.setDead(true); 
      }
   }
   
   public long getDuration(){
      long currentTime = System.currentTimeMillis();
      return currentTime - createdTime;
   }
   
   public long getCreateTime(){
      return this.createdTime; 
   }
   
   void setDead(){
     super.setDead();
   }  
}

class SpeedIcon extends SupportItem{
   long createdTime;
   SpeedIcon(PApplet applet, int xpos, int ypos){
      super(applet, "Speed_Icon.png", xpos, ypos);
      createdTime = System.currentTimeMillis();
   }
   
   void update(){
      if(this.getDuration() - this.getPauseDuration() > 60000){
         this.sprite.setDead(true); 
      }
   }
   
   public long getDuration(){
     long current_time = System.currentTimeMillis(); 
     return current_time - this.createdTime;
   }
}

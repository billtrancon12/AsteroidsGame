

class Ship extends GameObject
{
  float rotInc = .05;
  float direction;
  float accel = 30;
  double speed;
  float energy, restore, deplete;

  Ship(PApplet applet, int xpos, int ypos) 
  {
    direction = 0;
    energy = 2;
    restore = .005;
    deplete = .7;
    
    sprite = new Sprite(applet, "ships2.png", 2, 1, 50);
    sprite.tag = this;
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(.5);
    sprite.setFrame(0);

    // Domain keeps the moving sprite withing specific screen area 
    sprite.setDomain(0, 0, width, height, Sprite.REBOUND);
  }

  void update() 
  {
    processKeys();
    this.speed = (sprite.getSpeed() > 0.001) ? sprite.getSpeed() - 0.1: 0;
    sprite.setSpeed(this.speed);
    energy += restore;
    if(energy > 1) energy = 1;
    if(energy < 0) energy = 0;
  }

  void drawOnScreen()
  {
    // Draw a filled rectangle representing the ship's energy.
    float xpos = (float)sprite.getX() + 20;
    float ypos = (float)sprite.getY() - 40;
    float h = 10;

    fill(0);
    stroke(255);
    rect( xpos, ypos, 40, h);
    fill(255);
    
    float w = energy * 40;
    rect( xpos, ypos, w, h);
  }
  
  void processKeys() 
  {
    if (focused) {
      if (kbController.isUp()) {
        sprite.setFrame(1);
        sprite.setAcceleration(accel, direction - 1.5708);        
      } else {
        sprite.setFrame(0);
        sprite.setAcceleration(0);
      }

      if (kbController.isRight()) {
        direction += rotInc;
        sprite.setRot(direction);
      }

      if (kbController.isLeft()) {
        direction -= rotInc;
        sprite.setRot(direction);
      }
    }
  }
}


/*************************************************/


class Missile extends GameObject
{
  long createdTime;
  boolean muted;
  long pauseDuration;

  Missile(PApplet applet, int xpos, int ypos, boolean muted) 
  {
    this.muted = muted;
    
    sprite = new Sprite(applet, "missile.png", 40);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(.75);

    createdTime = System.currentTimeMillis();
    
    if(!this.muted)
      soundPlayer.playMissileLaunch();
  }

  void update() 
  {
    long currentTime = System.currentTimeMillis();
    // Run missile for 5 seconds
    if ((currentTime - createdTime - this.getPauseDuration()) > 5000) {
      sprite.setDead(true);
    }
  }
}

class BigAsteroid extends GameObject
{
  float rotInc = .1;
  float accel = 30;
  boolean muted;
  
  BigAsteroid(PApplet applet, int xpos, int ypos, int frame, float rotInc, float speed, float direction, boolean muted) 
  {
    this.rotInc = rotInc;
    this.muted = muted;
    
    sprite = new Sprite(applet, "asteroids.png", 3, 1, 51);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(.5);
    sprite.setFrame(frame);
    sprite.setSpeed(speed, direction);
    this.setSpeed(speed);
    this.setDirection(direction);

    // Domain keeps the moving sprite withing specific screen area 
    sprite.setDomain(0, 0, width, height, Sprite.REBOUND );
  }

  void update() 
  {
    sprite.setRot(sprite.getRot() + rotInc);
  }

  void setDead()
  {
    super.setDead();
    if(!muted)
      soundPlayer.playExplosionLargeAsteroid();
  }
}


/*****************************************/


class SmallAsteroid extends GameObject
{
  float rotInc = .1;
  float accel = 30;
  boolean muted;
  
  SmallAsteroid(PApplet applet, int xpos, int ypos, int frame, float rotInc, float speed, float direction, boolean muted) 
  {
    this.rotInc = rotInc;
    this.muted = muted;
    
    sprite = new Sprite(applet, "smallAsteroids.png", 3, 1, 51);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(.5);
    sprite.setFrame(frame);
    sprite.setSpeed(speed, direction);
    this.setSpeed(speed);
    this.setDirection(direction);

    // Domain keeps the moving sprite withing specific screen area 
    sprite.setDomain(0, 0, width, height, Sprite.REBOUND );
  }

  void update() 
  {
    sprite.setRot(sprite.getRot() + rotInc);
  }

  void setDead()
  {
    super.setDead();
    if(!this.muted)
      soundPlayer.playExplosionSmallAsteroid();
  }
}



class ExplosionLarge extends GameObject
{
  boolean muted;
  ExplosionLarge(PApplet applet, int xpos, int ypos, boolean muted) 
  {
    this.muted = muted;
     sprite = new Sprite(applet, "explosion.png", 8, 1, 60);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(1.0);
    sprite.setFrameSequence(0, 7, 0.3, 1);
    
    if(!this.muted)
      soundPlayer.playExplosionShip();
  }

  void update() 
  {
    if(!sprite.isImageAnimating()) {
      setDead();
    }
  }
}


/*****************************************/


class ExplosionSmall extends GameObject
{
  boolean muted;
  ExplosionSmall(PApplet applet, int xpos, int ypos, boolean muted) 
  {
    this.muted = muted;
    sprite = new Sprite(applet, "explosion.png", 8, 1, 60);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(.3);
    sprite.setFrameSequence(0, 7, 0.1, 1);
  }

  void update() 
  {
    if(!sprite.isImageAnimating()) {
      sprite.setDead(true);
    }
  }
}

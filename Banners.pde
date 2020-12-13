class GameOver extends GameObject
{
  float scale = .001;
  float scaleInc = .01;

  GameOver(PApplet applet, int xpos, int ypos) 
  {
    sprite = new Sprite(applet, "gameOver.png", 60);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(scale);
  }

  void update() 
  {
    if (scale < 2) {
      scale += scaleInc;
    }
    sprite.setScale(scale);
  }
}


/*****************************************/


class OhYea extends GameObject
{
  float scale = 0;
  float scaleInc = .05;

  OhYea(PApplet applet, int xpos, int ypos) 
  {
    sprite = new Sprite(applet, "OhYea.png", 60);
    sprite.setXY(xpos, ypos);
    sprite.setVelXY(0, 0);
    sprite.setScale(scale);
  }

  void update() 
  {
    scale += scaleInc;
    sprite.setScale(abs(sin(scale)*2));
    sprite.setX((sin(scale) * 100) + width/2);
    sprite.setY((cos(scale) * 200) + height/2);
    sprite.setRot((cos(scale) * PI));
  }
}

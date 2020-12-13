

abstract class GameObject 
{
  public Sprite sprite;
  public double direction;
  public float speed1;
  public double speed2;
  public double accel;
  public long pauseDuration;

  boolean checkCollision(Sprite osprite) 
  {
    return sprite.cc_collision(osprite);
  }
  
  public void setDirection(double direction){
    this.direction =  direction;
  }

  double getDirection(){
    return this.direction;  
  }
  
  public void setSpeed(float speed){
    this.speed1 = speed;  
  }
  
  public void setSpeed(double speed){
    this.speed2 = speed;  
  }
  
  public void setPauseDuration(long duration){
    this.pauseDuration = duration;  
  }
  
  long getPauseDuration(){
    return pauseDuration;  
  }
  
  float getSpeed(){
    return this.speed1;  
  }
  
  double getDoubleSpeed(){
    return this.speed2;
  }
  
  public void setAcceleration(double accel){
    this.accel = accel;  
  }
  
  double getAcceleration(){
    return this.accel;  
  }

  int getX() 
  {
    return (int)sprite.getX();
  }
  
  int getY() 
  {
    return (int)sprite.getY();
  }
  
  float getRot() 
  {
    return (float)sprite.getRot();
  }
  
  void setDead() 
  {
    sprite.setDead(true);
    S4P.deregisterSprite(sprite);
  }

  boolean isDead() 
  {
    return sprite.isDead();
  }
  
  boolean isTriggered()
  {
    return sprite.isDead();
  }
  
  void trigger()
  {
    sprite.setDead(false);
  }
  
  abstract void update();
  
  long getDuration(){return 0;}
}

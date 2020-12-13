
class AsteroidsLevelSystem extends GameLevel 
{
  Ship ship;
  MenuButton menuButton;
  ScoreTracker scoreTracker;
  
  CopyOnWriteArrayList<GameObject> asteroids;
  CopyOnWriteArrayList<GameObject> missiles;
  CopyOnWriteArrayList<GameObject> explosions;
  CopyOnWriteArrayList<GameObject> healthIcon;
  CopyOnWriteArrayList<GameObject> armorIcon;
  CopyOnWriteArrayList<GameObject> speedIcon;
    
  int numLives;
  int level_score;
  int total_score;
  float missileSpeed = 500;
  int level = 1;
  boolean shieldActive = false;
  boolean speedBoost = false;
  boolean muted;
  long shieldDuration = 0;
  long shieldCreate = 0;
  long speedCreate = 0;
  long speedDuration = 0;
  long createTime;
  long currentTime;
  long pauseTime;
  long pauseDuration;
  long pauseStart;
  long temp;
  long shieldPauseDuration;
  long shieldPausePrevious;
  long speedPauseDuration;
  long speedPausePrevious;
  long shipPauseDuration;
  long shipPausePrevious;
  
  int ba = 50;
  int sa = 10;
  
  AsteroidsLevelSystem(PApplet applet, int level, int numLives, boolean muted, MenuButton menuButton, int level_score, int total_score)
  {
    super(applet);
    this.muted = muted;
    this.applet = applet;
    this.level = level;
    this.numLives = numLives;
    this.menuButton = menuButton;
    this.pauseTime = 0;
    this.temp = 0;
    this.level_score = level_score;
    this.total_score = total_score;
  }

  void start()
  {    
    ship = new Ship(applet, width/2, height/2);
        
    missiles = new CopyOnWriteArrayList<GameObject>();
    explosions = new CopyOnWriteArrayList<GameObject>();
    healthIcon = new CopyOnWriteArrayList<GameObject>();
    armorIcon = new CopyOnWriteArrayList<GameObject>();
    speedIcon = new CopyOnWriteArrayList<GameObject>();
    
    healthIcon.add(new HealthIcon(applet, (int)random(0,800), (int)random(0,500)));
    armorIcon.add(new ArmorIcon(applet, (int)random(0,800), (int)random(0,500)));
    speedIcon.add(new SpeedIcon(applet, (int)random(0,800), (int)random(0,500)));
    
    this.menuButton.sprite.setFrame(0);
    this.createTime = System.currentTimeMillis();

    asteroids = new CopyOnWriteArrayList<GameObject>();
    for(int i = 0; i < level*2 + 1; i++){
       asteroids.add(new BigAsteroid(applet, (int)random(0,800), (int)random(0,500), (int)random(0,2), random(-0.02,0.02), 22, PI*random(0,2), this.muted)); 
    }
    
    
    gameState = GameState.Running;
  }

  void stop()
  {
    ship.setDead();

    // Remove all GameObjects
    for (GameObject missile : missiles) {
      missile.setDead();
      missiles.remove(missile);
    }

    for (GameObject asteroid : asteroids) {
      asteroid.setDead();
      asteroids.remove(asteroid);
    }

    for (GameObject explosion : explosions) {
      explosion.setDead();
      explosions.remove(explosion);
    }
    
    for(GameObject icon : healthIcon){
       icon.setDead();
       healthIcon.remove(icon);
    }
    
    for(GameObject icon : armorIcon){
       icon.setDead();
       armorIcon.remove(icon);
    }
    
    for(GameObject icon : speedIcon){
       icon.setDead(); 
       speedIcon.remove(icon);
    }
  }

  public boolean getVoiceState(){
     return true; 
  }

  void restart()
  {
    // Not Used / Implemented
  }

  void update() 
  { 
    sweepDeadObject();
    updateObjects();
        
    updatePauseTime();
  
    if (isGameOver()) {
      gameState = GameState.Finished;
    }
    
    checkShipCollisions();
    checkMissileCollisions();
    
    updateShield();
    updateSpeed();
  }
  
  void updateShield(){
    if(shieldActive && gameState == GameState.Running){      
      shieldDuration = currentTime - shieldPauseDuration - shieldCreate;  
    }
    if(shieldDuration > 10000){
       shieldActive = false;
       shieldDuration = 0;
    }    
  }
  
  void updateSpeed(){
    if(speedBoost && gameState == GameState.Running) speedDuration = currentTime - speedPauseDuration - speedCreate;
    if(speedDuration > 10000){
       ship.restore = 0.005;
       speedBoost = false;
       speedCreate = 0;
    }      
  }
  
  void updatePauseTime(){
    if(gameState == GameState.Running){
      temp = this.pauseDuration;
      shipPausePrevious = shipPauseDuration;
      shieldPausePrevious = (shieldPauseDuration > 0) ? this.shieldPauseDuration : 0;
      speedPausePrevious = (speedPauseDuration > 0) ? this.speedPauseDuration : 0;
    }
    if(gameState == GameState.Pause){
      this.pauseTime = System.currentTimeMillis();
      this.pauseDuration = temp + this.pauseTime - this.pauseStart;
      this.shipPauseDuration = shipPausePrevious + this.pauseTime - this.pauseStart;
      if(shieldCreate > 0){
        shieldPauseDuration = this.pauseTime - this.pauseStart + shieldPausePrevious;
      }
      
      if(speedCreate > 0){
        speedPauseDuration = this.pauseTime - this.pauseStart + speedPausePrevious;
      }
    }    
  }

  private boolean isGameOver() 
  {
    if (asteroids.size() == 0 && !ship.isDead()) {
      return true;
    } else {
      return false;
    }
  }

  GameState getGameState()
  {
    return gameState;
  }

  void drawOnScreen() 
  {
    String msg;

    fill(255);
    textSize(20);
    msg = "Level: "+this.level;
    text(msg,10,20);
    msg = "Life : "+this.numLives;
    text(msg,10,40);
    if(shieldActive) msg = "Shield : On";
    else msg = "Shield : Off";
    text(msg,830,20);
    if(shieldActive){
      msg = "Duration : "+ (int)(shieldDuration/1000 + 1);
      text(msg, 830, 40);
      if(speedBoost) msg = "Boost: On";
      else msg = "Boost: Off";
      text(msg, 830, 60);
      if(speedBoost){
        msg = "Duration: " + (int)(speedDuration / 1000 + 1);
        text(msg,830, 80);
      }
    }
    else{
      if(speedBoost) msg = "Boost: On";
      else msg = "Boost: Off";
      text(msg, 830, 40);
      if(speedBoost){
        msg = "Duration: " + (int)(speedDuration / 1000 + 1);
         text(msg, 830, 60);
      }
    }
    msg = "Level Score: " + this.level_score;
    text(msg,10,60);
    msg = "Total Score: " + this.total_score;
    text(msg,10,80);
    
    ship.drawOnScreen();
  }

  void keyPressed() 
  {
    if (key == ' ' && gameState == GameState.Running) {
      if (!ship.isDead()) {
        launchMissile(missileSpeed);
      }
    }
    if((key == 'p' || key == 'P') && gameState == GameState.Running){
      gameState = GameState.Pause;
      this.pauseStart = System.currentTimeMillis();
      pause(gameState);
    }
    else if((key == 'p' || key == 'P') && gameState == GameState.Pause){
      gameState = GameState.Running;
      pause(gameState);
    }
  }
  
  void pause(GameState state){
    for(GameObject missile : missiles){
      if(state == GameState.Pause){
        missile.setSpeed(missile.sprite.getSpeed());
        missile.sprite.setSpeed(0);
      }
      else if(state == GameState.Running)
        missile.sprite.setSpeed(500);
    }
    for(GameObject asteroid : asteroids){
      if(state == GameState.Pause){
        asteroid.setDirection(asteroid.sprite.getDirection());
        asteroid.sprite.setSpeed(0,0);
        asteroid.sprite.setRot(asteroid.sprite.getRot());
      }
      else if(state == GameState.Running)
        asteroid.sprite.setSpeed(asteroid.getSpeed(), asteroid.getDirection());
    }
    for(GameObject icon : healthIcon){
      if(state == GameState.Pause){
        icon.setDirection(icon.sprite.getDirection());
        icon.sprite.setSpeed(0,0);
      }
      else if(state == GameState.Running)
        icon.sprite.setSpeed(icon.getSpeed(), icon.getDirection());
    }
    for(GameObject icon : speedIcon){
      if(state == GameState.Pause){
        icon.setDirection(icon.sprite.getDirection());
        icon.sprite.setSpeed(0,0);
      }
      else if(state == GameState.Running)
        icon.sprite.setSpeed(icon.getSpeed(), icon.getDirection());
    }
    for(GameObject icon : armorIcon){
      if(state == GameState.Pause){
        icon.setDirection(icon.sprite.getDirection());
        icon.sprite.setSpeed(0,0);
      }
      else if(state == GameState.Running)
        icon.sprite.setSpeed(icon.getSpeed(), icon.getDirection());
    }
    if(state == GameState.Pause){
      ship.setSpeed(ship.sprite.getSpeed());
      ship.sprite.setSpeed(0);
      ship.setAcceleration(ship.sprite.getAcceleration());
      ship.sprite.setAcceleration(0,0);
    }
    else if(state == GameState.Running){
      ship.sprite.setSpeed(ship.getDoubleSpeed(), ship.sprite.getRot() - 1.5708);
      ship.sprite.setAcceleration(30, ship.sprite.getRot() - 1.5708);
    }
  }

  // Remove dead GameObjects from their lists. 
  private void sweepDeadObject()
  {
    // Remove expired missiles
    for (GameObject missile : missiles) {
      if (missile.isDead()) {
        missiles.remove(missile);
      }
    }

    // Remove expired asteroids
    for (GameObject asteroid : asteroids) {
      if (asteroid.isDead()) {
        asteroids.remove(asteroid);
      }
    }

    // Remove expired explosions
    for (GameObject explosion : explosions) {
      if (explosion.isDead()) {
        explosions.remove(explosion);
      }
    }
    
    //Remove the support item
    for (GameObject icon : healthIcon){
       if(icon.isDead()){
         healthIcon.remove(icon);
       }
    }
    
    for (GameObject icon : armorIcon){
       if(icon.isDead()){
         armorIcon.remove(icon);
       }
    }

    for (GameObject icon : speedIcon){
       if(icon.isDead()){
         speedIcon.remove(icon);
       }
    }
  }

  // Cause each GameObject to update their state.
  private void updateObjects()
  {
    if(gameState == GameState.Running){
      ship.update();
      for(GameObject asteroid : asteroids) {
        asteroid.update();
      }
    
      for(GameObject missile : missiles) {
        missile.setPauseDuration(this.pauseDuration);
        missile.update();
      }
    
      for(GameObject explosion : explosions) {
        explosion.update();
      }
    
      for(GameObject icon : healthIcon){
        icon.setPauseDuration(this.pauseDuration); 
        icon.update(); 
      }
    
      for(GameObject icon : armorIcon){
        icon.setPauseDuration(this.pauseDuration); 
        icon.update(); 
      }
    
      for(GameObject icon : speedIcon){
        icon.setPauseDuration(this.pauseDuration); 
        icon.update(); 
      }
    }
  }

  private void launchMissile(float speed) 
  {
    if(ship.energy >= .2) {
      Missile missile = new Missile(applet, ship.getX(), ship.getY(), this.muted);
      missile.sprite.setRot(ship.getRot() - 1.5708);
      missile.sprite.setSpeed(speed);
      missiles.add(missile);
  
      ship.energy -= ship.deplete;
    }
  }

  // Check missile to asteroid collisions
  private void checkMissileCollisions() 
  {

    if (ship.isDead()) return;

    // find a process missile - asteroid collisions
    for (GameObject missile : missiles) {
      for (GameObject asteroid : asteroids) {
        if (missile.checkCollision(asteroid.sprite)) {
          missile.setDead();
          missiles.remove(missile);

          asteroid.setDead();
          explosions.add(new ExplosionSmall(applet, asteroid.getX(), asteroid.getY(), this.muted));
          asteroids.remove(asteroid);
          total_score += sa;
          level_score += sa;
          
          
          if (asteroid instanceof BigAsteroid) {
            total_score += ba;
            level_score += ba;
            addSmallAsteroids(asteroid,level);
          }
        }
      }
    }
  }

  // Check ship to asteroid collisions
  private void checkShipCollisions() 
  {
    if (ship.isDead()) return;
    long currentTime = System.currentTimeMillis();
    this.currentTime = currentTime;
    // Dont collide with ship when first created and not moved.
    if ((ship.getX() == width/2 && ship.getY() == height/2 && (currentTime - this.createTime - shipPauseDuration) < 4500 && (currentTime - this.createTime - shipPauseDuration) > 0)) return;
    
    for(GameObject icon : speedIcon){
       if(!icon.isDead() && ship.checkCollision(icon.sprite)){
         this.speedBoost = true;
         this.speedCreate = System.currentTimeMillis();
         ship.restore = 0.01;
         icon.setDead();
         speedIcon.remove(icon);
       }
       break;
    }
    
    for(GameObject icon : armorIcon){
       if(!icon.isDead() && ship.checkCollision(icon.sprite)){
          this.shieldActive = true;
          this.shieldCreate = System.currentTimeMillis();
          icon.setDead();
          armorIcon.remove(icon);
       }
       break;
    }
    
    for(GameObject icon : healthIcon){
        if(!icon.isDead() && ship.checkCollision(icon.sprite)){
           numLives++; 
           icon.setDead();
          healthIcon.remove(icon);
        }
        break;
    }
    
    if(shieldDuration == 0){
      for (GameObject asteroid : asteroids) {
        if (!asteroid.isDead() && ship.checkCollision(asteroid.sprite)) {
          explosions.add(new ExplosionLarge(applet, ship.getX(), ship.getY(), this.muted));
          ship.setDead();
          if (numLives > 1) {
            ship = new Ship(applet, width/2, height/2);
            this.createTime = System.currentTimeMillis();
            shipPauseDuration = 0;
            shipPausePrevious = 0;
            numLives--;
            total_score = (total_score < sa) ? total_score : total_score - sa;
            level_score = (level_score < sa) ? level_score : level_score - sa;
          } else {
            gameState = GameState.Lost;
          }
        
          asteroid.setDead();
          asteroids.remove(asteroid);
          if (asteroid instanceof BigAsteroid) {
            addSmallAsteroids(asteroid,level);
            total_score = (total_score < ba) ? total_score : total_score - ba;
            level_score = (level_score < ba) ? level_score : level_score - ba;
          }

          break; // only happens once
        }
      }
    }
    

  }

  public int getNumLives(){
    return this.numLives;
  }
  
  public int getCurrentScore(){
    return this.level_score;
  }
  public int getTotalScore(){
    return this.total_score;
  }
  
  public boolean isTriggered(){ return true;}

  private void addSmallAsteroids(GameObject go, int level) 
  {
    int xpos = go.getX();
    int ypos = go.getY();
    for(int i = 0; i < level*2 + 1; i++){
      asteroids.add(new SmallAsteroid(applet, xpos, ypos, (int)random(0,2), random(-0.02,0.02), 44, PI*random(0,2), this.muted));
    }
  }
}

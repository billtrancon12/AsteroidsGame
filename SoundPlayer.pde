
import ddf.minim.*; // Import Sound Library

class SoundPlayer 
{
  Minim minimplay;
  AudioSample boomPlayer, popPlayer;
  AudioSample explosionLargeAsteroid, explosionShip, explosionSmallAsteroid;
  AudioPlayer ohYea, gameOverPlayer;
  AudioSample missileLaunch;
  SoundPlayer(Object app) 
  {
    minimplay = new Minim(app); 
    
    boomPlayer = minimplay.loadSample("explode.wav", 1024); 
    gameOverPlayer = minimplay.loadFile("ThatsAllFolks.wav", 1024); 
    popPlayer = minimplay.loadSample("pop.wav", 1024);
    explosionLargeAsteroid = minimplay.loadSample("LargAsteroidExplosion.wav", 1024);
    explosionSmallAsteroid = minimplay.loadSample("SmallAsteroidExplosion.wav", 1024);
    explosionShip = minimplay.loadSample("ExplosionShip.wav", 1024);
    ohYea = minimplay.loadFile("OhYea.wav", 1024);
    missileLaunch = minimplay.loadSample("MissileLaunch.wav", 1024);
  }

  void playExplosion() 
  {
    boomPlayer.trigger();
  }

  void playPop() 
  {
    popPlayer.trigger();
  }

  void playGameOver() 
  {
    gameOverPlayer.play();
  }
  
  void playExplosionLargeAsteroid() 
  {
    explosionLargeAsteroid.trigger();
  }

  void playExplosionSmallAsteroid() 
  {
    explosionSmallAsteroid.trigger();
  }
  
  void playExplosionShip() 
  {
    explosionShip.trigger();
  }

  void playOhYea() 
  {
    ohYea.play();
  }

  void playMissileLaunch() 
  {
    missileLaunch.trigger();
  }
  
  boolean isPlay(AudioPlayer audio){
    return audio.isPlaying();  
  }
}

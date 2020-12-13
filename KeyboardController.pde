
import org.gamecontrolplus.*;
import net.java.games.input.*;

class KeyboardController 
{
  ControlIO controllIO;
  ControlDevice keyboard;
  ControlButton spaceBtn, leftArrow, rightArrow, upArrow, downArrow, pauseButton, yButton;

  KeyboardController(PApplet applet) 
  {
    controllIO = ControlIO.getInstance(applet);
    keyboard = controllIO.getDevice("Keyboard");
    spaceBtn = keyboard.getButton("Space");   
    leftArrow = keyboard.getButton("Left");   
    rightArrow = keyboard.getButton("Right");
    upArrow = keyboard.getButton("Up");
    downArrow = keyboard.getButton("Down");
    pauseButton = keyboard.getButton("P");
    yButton = keyboard.getButton("Y");
  }

  boolean isUp() 
  {
    return upArrow.pressed();
  }

  boolean isDown() 
  {
    return downArrow.pressed();
  }

  boolean isLeft() 
  {
    return leftArrow.pressed();
  }

  boolean isRight() 
  {
    return rightArrow.pressed();
  }

  boolean isSpace() 
  {
    return spaceBtn.pressed();
  }
  boolean isPause(){
    return pauseButton.pressed();  
  }
  boolean isYes(){
    return yButton.pressed();  
  }
}

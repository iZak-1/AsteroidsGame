boolean wIsPressed = false;
boolean spaceIsPressed = false;
boolean aIsPressed = false;
boolean dIsPressed = false;

float teleportProgress=0; //percentage of the teleportation that's been done

Spaceship Dragon;
Star[] galaxy = new Star[250];
public void setup()
{
  size((int)(0.95*window.innerWidth), (int)(0.95*window.innerHeight)); 
  frameRate(100);
  Dragon = new Spaceship();
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i] = new Star();
  }
  textSize(height/50);
  textAlign(TOP,LEFT);
}
public void draw()
{
  background(0);
  
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i].show();
  }
  
  if(teleportProgress>0) { //if teleporting, keep teleporting
    Dragon.teleport();
  }
  else { //do non-teleportation stuff
    fill(255);
    text(Dragon.getData(3),width/100,height/50);
    if(aIsPressed) {
      Dragon.turn(-3);
    }
    if(dIsPressed) {
      Dragon.turn(3);
    }
    if(wIsPressed) {
      Dragon.accelerate(0.1);
      Dragon.thrust();
    }
    if(spaceIsPressed) { //if you hit the teleport button, stop and begin the teleportation sequence
      teleportProgress = 0.01;
      Dragon.setVel(0.0,0.0);
    }
    if(Dragon.getRot()>360||Dragon.getRot()<0) { //set rotation to be between 0 and 360.
      Dragon.rotDomain();
    }
  }
  Dragon.show();
  Dragon.move();
}


//check for key inputs
void keyPressed()
{
  if(key=='w')
  {
    wIsPressed = true;
  }
  else if (key == 'a')
  {
    aIsPressed = true;
  }
  else if (key == 'd')
  {
    dIsPressed = true;
  }
  else if (keyCode == 32)
  {
    spaceIsPressed = true;
  }
}
void keyReleased()
{
  if(key=='w')
  {
    wIsPressed = false;
  }
  else if (key == 'a')
  {
    aIsPressed = false;
  }
  else if (key == 'd')
  {
    dIsPressed = false;
  }
  else if (keyCode == 32)
  {
    spaceIsPressed = false;
  }
}

boolean wIsPressed = false;
boolean spaceIsPressed = false;
boolean aIsPressed = false;
boolean dIsPressed = false;
//^keys aren't being pressed


float teleportProgress=0; //percentage of the teleportation that's been done

ArrayList <Asteroid> roids;
Asteroid test = new Asteroid();
Asteroid noMoon;
Spaceship Dragon;
Star[] galaxy = new Star[100];
public void setup()
{
  size(1458, 685); //size((int)(0.95*window.innerWidth), (int)(0.95*window.innerHeight)); 
  frameRate(100);
  Dragon = new Spaceship();
  roids = new ArrayList <Asteroid>();
  for (int i = 0; i < 10; i++) { //draw the stars
    roids.add(new Asteroid());
  }
  for (int i = 0; i < galaxy.length; i++) { //draw the stars
    galaxy[i] = new Star();
  }
  textSize(height/40);
  textAlign(LEFT,TOP);
}
public void draw()
{
  background(0);
  
  for (int i = 0; i < galaxy.length; i++) { //show galaxies
    galaxy[i].show();
  }
  
  //ship stuff
  if(teleportProgress>0) { //if teleporting, keep teleporting
    Dragon.teleport();
  }
  else { //do non-teleportation stuff
    fill(255);
    text(Dragon.getData(3),width/100,height/50);
    if(aIsPressed) {
      Dragon.turn(-2);
    }
    if(dIsPressed) {
      Dragon.turn(2);
    }
    if(wIsPressed) {
      Dragon.accelerate(0.05);
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
  //end ship stuff
  
  for (int i = roids.size()-1; i >= 0; i--) { //show galaxies
      Asteroid activeRoid = roids.get(i);
      activeRoid.show();
      activeRoid.move();
      if(dist((float)activeRoid.getX(),(float)activeRoid.getY(),(float)Dragon.getX(),(float)Dragon.getY())<25) {
        roids.remove(i);
      }
  }
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

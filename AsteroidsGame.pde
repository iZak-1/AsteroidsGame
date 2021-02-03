boolean wIsPressed = false;
boolean aIsPressed = false;
boolean dIsPressed = false;
boolean spaceIsPressed = false;
//^keys aren't being pressed


float teleportProgress=0; //percentage of the teleportation that's been done

ArrayList <Asteroid> roids;
ArrayList <Bullet> bullets;
ArrayList <Particle> dust;
Spaceship Dragon;
Star[] galaxy = new Star[100];
int numRoids = 5;

int score = 0;

int start = 0;
int currentTime = 0;
int lastScore = 0;
int lastBullet = 0;
int explodeProgress = 0;
int explodeX = 0;
int explodeY = 0;

boolean gameIsOver = false;


float oddsOfBigRoid = 0.25;
float tempRand;

public void setup()
{
  //initialize variables
  currentTime=lastScore=lastBullet=start=millis();
  explodeX=explodeY=explodeProgress=score=0;
  numRoids=5;
  wIsPressed = aIsPressed = dIsPressed = spaceIsPressed = gameIsOver = false;

  loop();
  noCursor();
  size(1000, 500); //size((int)(0.95*window.innerWidth), (int)(0.95*window.innerHeight)); 
  frameRate(100);
  Dragon = new Spaceship();
  roids = new ArrayList <Asteroid>();
  bullets = new ArrayList <Bullet>();
  dust = new ArrayList <Particle>();
  for (int i = 0; i < numRoids; i++) { //draw the stars
    tempRand = (float)Math.random();
    if(tempRand<oddsOfBigRoid) {
      roids.add(new Asteroid(2));
    } else{
      roids.add(new Asteroid(0));
    }
    
  }
  for (int i = 0; i < galaxy.length; i++) { //draw the stars
    galaxy[i] = new Star();
  }
}
public void draw()
{
  background(0);

  for (int i = 0; i < galaxy.length; i++) { //show galaxies
    galaxy[i].show();
  }
  
  for (int i = dust.size()-1; i>=0; i--) { //show dust
    Particle activeDust = dust.get(i);
    activeDust.move();
    activeDust.show();
    activeDust.lessBeta();
    if(activeDust.getIsDead()) {
      //dust.remove(i);
    }
  }

  //ship stuff
  if (teleportProgress>0) { //if teleporting, keep teleporting
    Dragon.teleport();
  } else { //do non-teleportation stuff
    fill(255);
    textAlign(LEFT, TOP);
    textSize(height/40);
    text(Dragon.getData(3), width/100, height/50);

    textAlign(CENTER, BOTTOM);
    textSize(height/30);
    text("score: "+(int)score+"\n"+roids.size()+" asteroids", width/2, 9*height/10);
    if (aIsPressed) {
      Dragon.turn(-2);
    }
    if (dIsPressed) {
      Dragon.turn(2);
    }
    if (wIsPressed) {
      Dragon.accelerate(0.05);
      Dragon.thrust();
    }
    if (spaceIsPressed) { //if you hit the teleport button, stop and begin the teleportation sequence
      teleportProgress = 0.01;
      Dragon.setVel(0.0, 0.0);
    }
    if (Dragon.getRot()>360||Dragon.getRot()<0) { //set rotation to be between 0 and 360.
      Dragon.rotDomain();
    }
  }
  Dragon.show();
  Dragon.move();
  //end ship stuff
  
  
  for (int i = roids.size()-1; i >= 0; i--) { //show roids
    Asteroid activeRoid = roids.get(i);
    activeRoid.show();
    activeRoid.move();
    if (dist((float)activeRoid.getX(), (float)activeRoid.getY(), (float)Dragon.getX(), (float)Dragon.getY())<activeRoid.getRad()+10&&teleportProgress==0) {
      noLoop();
      gameIsOver = true;
    }
  }

  for (int i = bullets.size()-1; i >= 0; i--) { //move/show bullets
    Bullet activeBullet = bullets.get(i);
    activeBullet.show();
    activeBullet.move();

    for (int a = roids.size()-1; a >= 0; a--) { //check for roid collision
      Asteroid activeRoid = roids.get(a);
      if (dist((float)activeRoid.getX(), (float)activeRoid.getY(), (float)activeBullet.getX(), (float)activeBullet.getY())<activeRoid.getRad()+3) {
        
        if(activeRoid.getType()==2) { //if it's a big asteroid do break it up and make particles
          for(int numNewRoids = 0; numNewRoids<=4*Math.random(); numNewRoids++) {
            roids.add(new Asteroid(activeRoid));
          }
          for(int numDust = 0; numDust<=500*Math.random(); numDust ++) {
            dust.add(new Particle(activeRoid.getX(),activeRoid.getY()));
          }
          roids.remove(a);
          score+=20;
        } else{
          roids.remove(a);
          score+=25;
        }
        bullets.remove(i);
      }
    }
    if (activeBullet.isDead()) //check for dead bullets
    {
      bullets.remove(i);
    }
  }
  if (explodeProgress>0) { //explosion attack
    fill(255, 0, 0, 100);
    stroke(255, 100, 0);
    ellipse(explodeX, explodeY, explodeProgress, explodeProgress);
    explodeProgress+=5;
    for (int i = roids.size()-1; i >= 0; i--) { //show roids
      Asteroid activeRoid = roids.get(i);
      if (dist((float)activeRoid.getX(), (float)activeRoid.getY(), (float)explodeX, (float)explodeY)<explodeProgress) {
        roids.remove(i);
        score+=15;
      }
    }
    if (explodeProgress>=200) {
      explodeProgress=0;
    }
  }


  if ((int)(millis()-currentTime)/2500.0>=1/Math.sqrt(((millis()-start)/2000)+2)) { //spawn new asteroid. The complicated mathy bits is so that more asteroids spawn as time goes on
    tempRand = (float)Math.random();
    if(tempRand<oddsOfBigRoid) {
      roids.add(new Asteroid(2));
    } else{
      roids.add(new Asteroid(0));
    }
    currentTime = millis();
  }
  if ((int)(millis()-lastScore)/1000.0>=1) { //add a point every second
    score++;
    lastScore = millis();
  }

  if (mousePressed&&(mouseButton == LEFT)&&(millis()-lastBullet)/1000.0>=0.25) {  //shoot
    bullets.add(new Bullet(Dragon));
    bullets.get(bullets.size()-1).accelerate(25);
    lastBullet = millis();
  }
  
  //if there's 1 asteroid left, add two more!
  if(roids.size()<=1) {
    roids.add(new Asteroid(0));
    roids.add(new Asteroid(0));
  }
  
  if (gameIsOver) {
    noLoop();
    Dead();
  }
}

void Dead () {
  background(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(width/10);
  fill(255);
  text("GAME OVER", width/2, height/3);
  textSize(width/25);
  text("SCORE: "+score, width/2, 3*height/4);
}
//check for key inputs
void keyPressed()
{
  if (key=='w')
  {
    wIsPressed = true;
  } else if (key == 'a')
  {
    aIsPressed = true;
  } else if (key == 'd')
  {
    dIsPressed = true;
  } else if (keyCode == 32)
  {
    spaceIsPressed = true;
  }

  if (key == BACKSPACE) {
    setup();
  }
}
void keyReleased()
{
  if (key=='w')
  {
    wIsPressed = false;
  } else if (key == 'a')
  {
    aIsPressed = false;
  } else if (key == 'd')
  {
    dIsPressed = false;
  } else if (keyCode == 32)
  {
    spaceIsPressed = false;
  }
}
void mouseClicked() {
  if (mouseButton == RIGHT&&explodeProgress==0) {
    score -=50;
    explodeX=(int)Dragon.getX();
    explodeY=(int)Dragon.getY();
    explodeProgress=1;
  }
}

class Spaceship extends Floater  
{
  private float beta;
  Spaceship() {
    myColor=255;
    corners = 3;
    xCorners = new int[] {-10,-10,10};
    yCorners = new int[] {-10,10,0};
    myCenterX=width/2;
    myCenterY=height/2;
    beta=255;
    myPointDirection = 0;
    myXspeed=myYspeed=0;
  }
  
  public void thrust () {
    pushMatrix();
    fill(myColor,beta);
    stroke(myColor,beta);

    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()
    float dRadians = (float)(myPointDirection*(Math.PI/180));

    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);

    //draw the polygon
    line(-15,0,-25,0);
    line(-15,-3,-25,-6);
    line(-15,3,-25,6);
    
    popMatrix();
  }
  
  public void show ()  //Draws the floater at the current position  
  {
    pushMatrix();
    fill(myColor,beta);
    stroke(myColor,beta);

    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()
    float dRadians = (float)(myPointDirection*(Math.PI/180));

    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);

    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);
    
    popMatrix();
  }
  
  public void teleport() {
    teleportProgress+=0.75; //incriment the percentage of teleportation
    beta=(100-teleportProgress)*255/100; //set transparency 
    myColor=color((int)(255.0*Math.random()),(int)(255.0*Math.random()),(int)(255.0*Math.random())); //flash colors
    turn(0.5*teleportProgress); //spin
    if(teleportProgress>=100){ //if it's done teleporting, give it a new position and rotation, and make the teleport progress be zero (so it stops teleporting)
      turn(360.0*Math.random());
      setPos(width*Math.random(),height*Math.random());
      teleportProgress=0;
      beta=255;
      myColor=255;
    }
  }
  public void setBeta(float newBeta) {
    beta = newBeta;
  }
  public void setPos(double newX, double newY) {
    myCenterX=newX;
    myCenterY=newY;
  }
  public void setVel(double xvel, double yvel) {
    myXspeed=xvel;
    myYspeed=yvel;
  }
  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
  public double getRot() {
    return myPointDirection;
  }
  public void rotDomain() {
    double oldRot = myPointDirection;
    Dragon.turn(0-oldRot);
    Dragon.turn((360+oldRot%360)%360);
  }
  public String getData(int decimals) {
    return "x: "+nf((float)myCenterX,0,decimals)+"\ny: "+nf((float)myCenterY,0,decimals)+"\nhoriz. speed: "+nf((float)myXspeed,0,decimals)+"\nvert. speed: "+nf((float)myYspeed,0,decimals)+"\nrot: "+round((float)myPointDirection)+"°";
  }
}

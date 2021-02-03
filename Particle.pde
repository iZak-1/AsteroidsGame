class Particle extends Floater {
  private int deathTime;
  private int beta=100;
  Particle(double x, double y) {
    myCenterX=x;
    myCenterY=y;
    myPointDirection=360*Math.random();
    myColor = 255;
    myXspeed=5*Math.random()-2.5;
    myYspeed=5*Math.random()-2.5;
    deathTime = (int)(millis()+250+(500*Math.random()));
  }
  
  public void show() {
    fill(myColor,myColor,myColor,beta);   
    stroke(myColor,myColor,myColor,beta); 
    ellipse((float)myCenterX,(float)myCenterY,3,3);
  }
  public void move ()   //move the floater in the current direction of travel
  {
    //change the x and y coordinates by myXspeed and myYspeed       
    myCenterX += myXspeed;    
    myCenterY += myYspeed;
    //don't wrap
  }   
  public boolean getIsDead() {
    if(millis()>=deathTime) {return true;}
    else{return false;}
  }
  public void lessBeta() {
    beta-=2;
  }
}

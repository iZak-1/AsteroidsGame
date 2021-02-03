class Bullet extends Floater
{
  Boolean isDead = false;
  Bullet(Spaceship parentShip) {
    myColor = 255;
    myCenterX = parentShip.getX();
    myCenterY = parentShip.getY();
    myPointDirection = parentShip.getRot();
    corners = 4;
    xCorners = new int[] {-3,-3,3,3};
    yCorners = new int[] {-3,3,3,-3};
  }
  public void move ()   //move the floater in the current direction of travel
  {
    //change the x and y coordinates by myXspeed and myYspeed       
    myCenterX += myXspeed;    
    myCenterY += myYspeed;
    if(myCenterX >width||myCenterX<0||myCenterY >height||myCenterY < 0)
    {     
      isDead = true;
      myXspeed=myYspeed=0;
    }
  }
  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
  public boolean isDead() {
    return isDead;
  }
}

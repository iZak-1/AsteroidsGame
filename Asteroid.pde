class Asteroid extends Floater
{
  private float rotSpeed;
  private int startSide = (int)(4.0*Math.random());
  
  Asteroid() {
    myColor=150;
    
    
    //CORNERS FUNCTION

    float CycleRad=0;
    ArrayList<Float> radii = new ArrayList<Float>();
    ArrayList<Float> rads = new ArrayList<Float>();
    corners = 0;

    while(CycleRad<(2*PI)) {
      radii.add((float)(Math.random()*14)-7);
      rads.add(CycleRad);
      CycleRad+=0.25+Math.random();
      corners++;
    }
    xCorners = new int[corners];
    yCorners = new int[corners];
    System.out.println("NEWROID");
    for(int i = 0; i<corners; i++) {
      xCorners[i]=(int)((radii.get(i)+15)*cos(rads.get(i)));
      yCorners[i]=(int)((radii.get(i)+15)*sin(rads.get(i)));
      System.out.println("("+xCorners[i]+","+yCorners[i]+")");
    }
    System.out.println("corners: "+corners);
    
    rotSpeed=(float)(5.0*Math.random())-2.5;
    myPointDirection = 0;
    myXspeed=(5*Math.random())-2.5;
    myYspeed=(5*Math.random())-2.5;
    
    if(startSide==0) { //where it should start
      myCenterX=0;
      myCenterY=Math.random()*height;
    } else if(startSide==2) {
      myCenterX=width;
      myCenterY=Math.random()*height;
    } else if(startSide==1) {
      myCenterX=Math.random()*width;
      myCenterY=0;
    } else if(startSide==3) {
      myCenterX=Math.random()*width;
      myCenterY=height;
    }
  }
  
  public void move() {
    turn(rotSpeed);
    super.move();
  }
  /**
  public void show ()  //copy-pasted, no idea why it doesn't work with the regular inheritance  
  { 
    System.out.println("Show from asteroid");
    fill(myColor);   
    stroke(myColor);    
    
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

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }   
  */
  
  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
}

class Asteroid extends Floater  
{
  private float rotSpeed;
  int corners;
  private int startSide = (int)(4.0*Math.random());
  
  Asteroid() {
    myColor=255;
    
    
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
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myXspeed and myYspeed       
    myCenterX += myXspeed;    
    myCenterY += myYspeed;
    myPointDirection+=rotSpeed;

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    } 
    
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }
  
  public void show ()  //Draws the floater at the current position  
  {
    
    pushMatrix();
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
    
    popMatrix();
  }
  
  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
}

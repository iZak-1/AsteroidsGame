class Asteroid extends Floater
{
  protected float rotSpeed;
  protected int startSide;
  protected int roidType; //0 is normal, 1 is small from a big, 2 is big.
  protected int baseRadius;

  Asteroid(int Type) {
    startSide = (int)(4.0*Math.random());;
    roidType = Type;
    myColor=150;
    if(Type==0) {
      baseRadius=15;
    }
    else if(Type==2) {
      baseRadius=25;
    }
    
    rotSpeed=(float)(5.0*Math.random())-2.5;
    myPointDirection = 0;
    myXspeed=(0.5*Math.log(millis()-start+1000))*(0.5-Math.random());
    myYspeed=(0.5*Math.log(millis()-start+1000))*(0.5-Math.random());
    
    generateCorners();
    startPos();
  }
  Asteroid(Asteroid parentRoid) { //for asteroids that are from big asteroids being broken
    roidType = 1;
    myColor=150;
    baseRadius=10;
    
    rotSpeed=(float)(5.0*Math.random())-2.5;
    myPointDirection = 0;
    myXspeed=(0.5*Math.log(start+1000))*(0.5-Math.random());
    myYspeed=(0.5*Math.log(start+1000))*(0.5-Math.random());
    
    generateCorners();
    myCenterX=parentRoid.getX();
    myCenterY=parentRoid.getY();
  }
  
  protected void startPos() { //where to start
    if (startSide==0) { //where it should start
      myCenterX=0;
      myCenterY=Math.random()*height;
    } else if (startSide==2) {
      myCenterX=width;
      myCenterY=Math.random()*height;
    } else if (startSide==1) {
      myCenterX=Math.random()*width;
      myCenterY=0;
    } else if (startSide==3) {
      myCenterX=Math.random()*width;
      myCenterY=height;
    }
  }
  
  protected void generateCorners() {
    float CycleRad=0;
    ArrayList<Float> radii = new ArrayList<Float>();
    ArrayList<Float> rads = new ArrayList<Float>();
    corners = 0;

    while (CycleRad<(2*PI)) {
      radii.add((float)(Math.random()*6)-3);
      rads.add(CycleRad);
      CycleRad+=0.25+Math.random();
      corners++;
    }
    xCorners = new int[corners];
    yCorners = new int[corners];
    for (int i = 0; i<corners; i++) {
      xCorners[i]=(int)((radii.get(i)+baseRadius)*cos(rads.get(i)));
      yCorners[i]=(int)((radii.get(i)+baseRadius)*sin(rads.get(i)));
    }
  }
  public void move() {
    turn(rotSpeed);
    super.move();
  }

  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
  public int getType() {
    return roidType;
  }
  public int getRad() {
    return baseRadius;
  }
}

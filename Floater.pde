class Floater //Do NOT modify the Floater class! Make changes in the Spaceship class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myFillColor;   
  protected int myStrokeColor;
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double speedCap; //set to -1 for no cap
  protected double myXspeed, myYspeed; //holds the speed of travel in the x and y directions   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  protected int health, maxHealth;
  protected int damage;
  
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myXspeed += ((dAmount) * Math.cos(dRadians));    
    myYspeed += ((dAmount) * Math.sin(dRadians));       
  }   
  public void turn (double degreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=degreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myXspeed and myYspeed       
    myCenterX += myXspeed;    
    myCenterY += myYspeed;     
    
    //caps speed
    double overCap = Math.sqrt(Math.pow(myXspeed,2)+Math.pow(myYspeed,2))/speedCap;
    if (overCap > 1) {
      myXspeed*=(1/overCap);
      myYspeed*=(1/overCap);
    }
    
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
    fill(myFillColor);   
    stroke(myStrokeColor);    
    
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
  public void hit(int dmg) {
    health -= dmg;
  }
  public int getHealth() {
    return health;
  }
  public int getDamage() {
    return damage;
  }
  public double getX() {
    return myCenterX;
  }
  public double getY() {
    return myCenterY;
  }
  public double getXspeed() {
    return myXspeed;
  }
  public double getYspeed() {
    return myYspeed;
  }
  public double getPointDirection() {
    return myPointDirection;
  }
  public boolean collides(Floater obj, double dist) {
    return(Math.sqrt(Math.pow(myCenterX - obj.getX(), 2) + Math.pow(myCenterY - obj.getY(), 2)) < dist);
  }
} 

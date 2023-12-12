class Pickup extends Floater {
  private String type;
  private double rotSpeed;
  private int myInnerColor, myInnerStroke;
  private int n;
  public Pickup(String t, double x, double y) {
    myCenterX = x;
    myCenterY = y;
    type = t;
    corners = 6;
    n = 12;
    int nx = (int)(n/2.0);
    int ny = (int)(n*Math.sqrt(3)/2.0);
    xCorners = new int[]{n,nx,-nx,-n,-nx,nx};
    yCorners = new int[]{0,ny,ny,0,-ny,-ny};
    myFillColor = #228888;
    myStrokeColor = color(0,0); 
    myInnerColor = #44DDDD;
    myInnerStroke = #88FFFF;
    myXspeed = 6*Math.random()-3;
    myYspeed = 6*Math.random()-3;
    rotSpeed = 5*Math.random()-2.5;
  }
  
  public void move() {
    //in main game loop, removes if wraps around edges
    myCenterX += myXspeed;
    myCenterY += myYspeed;
    myPointDirection += rotSpeed;
  }
  
  public int getRadius() {
    return n;
  }
  
  public String getType() {
    return type;
  }
  
  public void show() {
    super.show();
    translate((float)myCenterX,(float)myCenterY);
    rotate((float)(myPointDirection*(Math.PI/180)));
    fill(myInnerColor);
    stroke(myInnerStroke);
    
    switch(type) {
      case "Repair":
        beginShape();
        vertex(n*3/5,n/7);
        vertex(n*3/5,-n/7);
        vertex(n/7,-n/7);
        vertex(n/7,-n*3/5);
        vertex(-n/7,-n*3/5);
        vertex(-n/7,-n/7);
        vertex(-n*3/5,-n/7);
        vertex(-n*3/5,n/7);
        vertex(-n/7,n/7);
        vertex(-n/7,n*3/5);
        vertex(n/7,n*3/5);
        vertex(n/7,n/7);
        endShape(CLOSE);
        break;
        
      case "Mines":
        beginShape();
        vertex(n*2/3,0);
        vertex(n*4/15,n*4/15);
        vertex(0,n*2/3);
        vertex(-n*4/15,n*4/15);
        vertex(-n*2/3,0);
        vertex(-n*4/15,-n*4/15);
        vertex(0,-n*2/3);
        vertex(n*4/15,-n*4/15);
        endShape(CLOSE);
        break;
      
      case "Missiles":
        scale(0.8);
        beginShape();
        vertex(-n/2,-n/4);
        vertex(0,-n/4);
        vertex(3*n/4,0);
        vertex(0,n/4);
        vertex(-n/2,n/4);
        endShape(CLOSE);
        scale(1/0.8);
        break;
        
      case "Lightning":
      
      
      case "Shield":
      
      
      case "Weapon":
      
      
    }
    rotate(-1*(float)(myPointDirection*(Math.PI/180)));
    translate(-1*(float)myCenterX,-1*(float)myCenterY);
  }
  
  /***
  Types to implement, and their icons:
  (pickups appear as a small box - will need to change mine appearance)
  
    Repair (plus)
      Increases health of spaceship.
    
    Ammunition (Mines/Missiles/Lightning)
      Increases amount of respective special weapon.
    
    Shield Boost (shield - as in medieval shield, not the octagon)
      Gives unbreakable shield for a short time.
    Weapon Boost (lightning bolt)
      Increases all weapon damage for a short time.
    ***/
}

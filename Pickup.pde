class Pickup extends Floater {
  private String type;
  private double rotSpeed;
  public Pickup(String t, double x, double y) {
    myCenterX = x;
    myCenterY = y;
    type = t;
    corners = 6;
    int n = 10;
    int nx = (int)(n/2.0);
    int ny = (int)(n*Math.sqrt(3)/2.0);
    xCorners = new int[]{n,nx,-nx,-n,-nx,nx};
    yCorners = new int[]{0,ny,ny,0,-ny,-ny};
    myFillColor = #000000;
    myStrokeColor = #FFFFFF;
    rotSpeed = 5*Math.random()-2.5;
  }
  
  public void move() {
    //in main game loop, will remove if wraps around edges
    myCenterX += myXspeed;
    myCenterY += myYspeed;
    myPointDirection += rotSpeed;
  }
  
  public void show() {
    super.show();
    //translate() whatever w/o rotating
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

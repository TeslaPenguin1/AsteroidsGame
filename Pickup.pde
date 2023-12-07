class Pickup extends Floater {
  private String type;
  public Pickup(String t, double x, double y) {
    myCenterX = x;
    myCenterY = y;
    type = t;
    corners = 4;
    xCorners = new int[]{5,5,-5,-5};
    yCorners = new int[]{5,-5,-5,5};
  }
  
  public void move() {
    //in main game loop, will remove if wraps around edges
    myCenterX += myXspeed;
    myCenterY += myYspeed;
  }
  
  public void show() {
    super.show();
    //draw icon (listed below) on top of shape
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

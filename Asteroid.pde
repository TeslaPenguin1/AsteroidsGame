class Asteroid extends Floater {
  private double rotSpeed;
  private int size;
  private int variant;
  Asteroid() {
    variant = (int)(Math.random()*4);
    if (variant == 0) {
      corners = 12;
      xCorners = new int[]{0,32,27,43,35,11,7,-4,-19,-21,-39,-25};
      yCorners = new int[]{40,25,3,-18,-35,-36,-13,-34,-30,-20,3,25};
    }
    if (variant == 1) {
      corners = 12;
      xCorners = new int[]{3,18,37,33,43,35,7,-10,-25,-27,-9,5};
      yCorners = new int[]{38,39,28,17,-7,-11,-13,-27,-11,14,29,21};
    }
    if (variant == 2) {
      corners = 15;
      xCorners = new int[]{4,9,27,37,33,40,35,20,5,-19,-17,-38,-36,-32,-18};
      yCorners = new int[]{23,11,33,19,3,-13,-29,-21,-37,-38,-17,-10,-4,20,32};
    }
    if (variant == 3) {
      corners = 9;
      xCorners = new int[]{7,13,29,30,12,-18,-19,-35,-23};
      yCorners = new int[]{35,18,6,-20,-37,-22,-4,2,23};
    }
    myFillColor = #000000;
    myStrokeColor = #FFFFFF;
    myCenterX = 500;
    myCenterY = 500;
    myXspeed = 6*Math.random()-3;
    myYspeed = 6*Math.random()-3;
    myPointDirection = 0;
    rotSpeed = 5*Math.random()-2.5;
    size = 2;
  }
  public void move() {
    myPointDirection += rotSpeed;
    super.move();
  }
}

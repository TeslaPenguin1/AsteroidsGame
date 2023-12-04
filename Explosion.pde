class Explosion extends Projectile {
  private int maxSize;
  public Explosion(Projectile proj, int max) {
    myCenterX = proj.getX();
    myCenterY = proj.getY();
    myXspeed = myYspeed = myPointDirection = 0;
    size = 30;
    maxSize = max;
    myFillColor = color(255,0,0,127);
    myStrokeColor = #FF0000;
    corners = 8;
    xCorners = new int[]{0,0,0,0,0,0,0,0};
    yCorners = new int[]{0,0,0,0,0,0,0,0};
  }
  public void show() {
    double midpoint = Math.sqrt(size/2.0);
    xCorners = new int[]{size,(int)midpoint,0,(int)-midpoint,-size,(int)-midpoint,0,(int)midpoint};
    yCorners = new int[]{0,(int)midpoint,size,(int)midpoint,0,(int)-midpoint,0,(int)-midpoint};
    size++;
  }
}

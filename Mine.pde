class Mine extends Projectile {
  private double rotSpeed;
  public Mine(Spaceship ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myXspeed = ship.getXspeed();
    myYspeed = ship.getYspeed();
    myPointDirection = ship.getPointDirection();
    timer = 750;
    damage = 30;
    corners = 8;
    xCorners = new int[]{5, 2 ,0, -2, -5, -2,  0,  2};
    yCorners = new int[]{0, 2, 5,  2,  0, -2, -5, -2};
    rotSpeed = 5*Math.random()-2.5;
    myFillColor = #000000;
    myStrokeColor = #FFFFFF;
    speedCap = -1;
    size = 10;
    explodeSize = 100;
    remove = true;
    explosive = true;
  }
  public void move() {
    myXspeed -= myXspeed*0.003;
    myYspeed -= myYspeed*0.003;
    myPointDirection += rotSpeed;
    super.move();
  }
}

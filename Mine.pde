class Mine extends Projectile {
  public Mine(Spaceship ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myXspeed = ship.getXspeed();
    myYspeed = ship.getYspeed();
    myPointDirection = ship.getPointDirection();
    timer = 750;
    damage = 30;
    corners = 4;
    xCorners = new int[]{5,0,-5,0};
    yCorners = new int[]{0,5,0,-5};
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
    super.move();
  }
}

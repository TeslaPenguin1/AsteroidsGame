class Bullet extends Projectile {
  public Bullet(Spaceship ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myXspeed = ship.getXspeed();
    myYspeed = ship.getYspeed();
    speedCap = -1;
    myPointDirection = ship.getPointDirection();
    accelerate(12);
    timer = 90;
    damage = 3;
    size = 1;
    debug = false;
    explosive = false;
    explodeSize = 10;
    remove = true;
  }
  public void show() {
    fill(#FFFFFF);
    stroke(#FFFFFF);
    ellipse((float)myCenterX, (float)myCenterY, 3,3);
  }
}

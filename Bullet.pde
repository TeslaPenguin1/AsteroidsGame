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
    explodeSize = 0;
    remove = true;
  }
  public void show() {
    fill(#FFFFFF);
    ellipse((float)myCenterX, (float)myCenterY, 3,3);
  }
}

class Bullet extends Floater {
  protected int timer;
  public Bullet(Spaceship ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myXspeed = ship.getXspeed();
    myYspeed = ship.getYspeed();
    myPointDirection = ship.getPointDirection();
    accelerate(12);
    timer = 90;
    damage = 3;
  }
  public void show() {
    fill(#FFFFFF);
    ellipse((float)myCenterX, (float)myCenterY, 3,3);
    timer--;
  }
  public int getTimer() {
    return timer;
  }
}

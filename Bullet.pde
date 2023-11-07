class Bullet extends Floater {
  private int timer;
  Bullet(Spaceship ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myXspeed = ship.getXspeed();
    myYspeed = ship.getYspeed();
    myPointDirection = ship.getPointDirection();
    accelerate(6);
    timer = 120;
  }
  public void show() {
    fill(#FFFFFF);
    ellipse((float)myCenterX, (float)myCenterY, 2,2);
    timer--;
  }
  public int getTimer() {
    return timer;
  }
}

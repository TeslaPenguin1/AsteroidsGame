class Projectile extends Floater {
  protected int timer;
  protected int size;
  protected boolean debug;
  public int getTimer() {
    return timer;
  }
  public int getSize() {
    return size;
  }
  public void move() {
    timer--;
    super.move();
  }
  public void doDebug(boolean d) {
    debug = d;
  }
  public void show() {
    if (debug) {
      noFill();
      strokeWeight(3);
      stroke(#FFFF00);
      ellipse((float)myCenterX,(float)myCenterY,(float)size,(float)size);
      strokeWeight(1);
    }
    super.show();
  }
}

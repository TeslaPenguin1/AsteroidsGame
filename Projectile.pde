class Projectile extends Floater {
  protected int timer;
  protected int size;
  protected int explodeSize;
  protected boolean remove, explosive, damageSelf;
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
  public boolean canRemove() {
    return remove;
  }
  public boolean doesExplode() {
    return explosive;
  }
  public boolean damagesSelf() {
    return damageSelf;
  }
  public void show() {
    if (debug) {
      noFill();
      strokeWeight(3);
      stroke(#FFFF00);
      ellipse((float)myCenterX,(float)myCenterY,(float)2*size,(float)2*size);
      strokeWeight(1);
    }
    super.show();
  }
  public void explode(ArrayList a) {
    if (explosive) {
      a.add(new Explosion(this, explodeSize, a));
    }
  }
}

class Explosion extends Projectile {
  private int maxSize;
  private int midpoint;
  private boolean rise;
  private ArrayList<Projectile> list;
  public Explosion(Projectile proj, int max, ArrayList al) {
    myCenterX = proj.getX();
    myCenterY = proj.getY();
    myXspeed = myYspeed = myPointDirection = 0;
    size = 0;
    maxSize = max;
    damage = max;
    timer = -1;
    list = al;
    myFillColor = color(255,0,0,127);
    myStrokeColor = #FF0000;
    midpoint = 0;
    corners = 8;
    xCorners = new int[]{size,midpoint,0,-midpoint,-size,-midpoint,0,midpoint};
    yCorners = new int[]{0,midpoint,size,midpoint,0,-midpoint,-size,-midpoint};
    remove = false;
    rise = true;
    damageSelf = true;
  }
  public void show() {
    midpoint = (int)Math.sqrt(Math.pow(size,2)/2.0);
    xCorners = new int[]{size,midpoint,0,-midpoint,-size,-midpoint,0,midpoint};
    yCorners = new int[]{0,midpoint,size,midpoint,0,-midpoint,-size,-midpoint};
    super.show();
  }
  public void move() {
    if (size < maxSize && rise) {
      size++;
      if (damage > 1) damage--;
    }
    else {
      rise = false;
      size-=2;
    }
    if (size < 0) timer = 0;
    for(int i = list.size() - 1; i >= 0; i--) {
      if (list.get(i).doesExplode() && this.collides(list.get(i),size)) {
        list.get(i).explode(list);
        list.remove(i);
      }
    }
  }
}

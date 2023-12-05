class Asteroid extends Floater {
  private double rotSpeed;
  private int size;
  public Asteroid(int n, double x, double y) {
    size = n;
    speedCap = -1;
    corners = (int)(Math.random()*5)+10+15*size;
    
    xCorners = new int[corners];
    yCorners = new int[corners];
    
    for(int i = 0; i < corners; i++) {
      int dist = (int)(Math.random()*corners/4 + 3*corners/4);
      xCorners[i] = (int)(dist * Math.cos(2*PI*i/corners));
      yCorners[i] = (int)(dist * Math.sin(2*PI*i/corners));
    }

    myFillColor = 127;
    myStrokeColor = #FFFFFF;
    myCenterX = x;
    myCenterY = y;
    myXspeed = 6*Math.random()-3;
    myYspeed = 6*Math.random()-3;
    myPointDirection = 0;
    rotSpeed = 5*Math.random()-2.5;
    health = maxHealth = 3+size*3;
    damage = 9+size*3;
  }
  public void move() {
    myPointDirection += rotSpeed;
    super.move();
    myFillColor = 127*(health-3)/12;
    if (myFillColor < 0) myFillColor = 0;
  }
  public void show() {
    super.show();
    if (debug) {
      noFill();
      strokeWeight(3);
      stroke(#FF0000);
      ellipse((float)myCenterX,(float)myCenterY,(float)getRadius()*2,(float)getRadius()*2);
      strokeWeight(1);
    }
  }
  public int getSize() {
    return size;
  }
  public double getRadius() {
    return corners*7/8.0;
  }
  public void split(ArrayList list) {
    list.add(new Asteroid(size-1, myCenterX,myCenterY));
    list.add(new Asteroid(size-1, myCenterX,myCenterY));
  }
}

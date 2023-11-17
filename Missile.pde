class Missile extends Bullet {
  private Floater target;
  private double targetX, targetY, targetAngle, myRad, speedCap;
  public Missile(Spaceship ship, Floater tgt) {
    super(ship);
    target = tgt;
    timer = -1;
    speedCap = 30;
  }
  public void target(Floater tgt) {
    target = tgt;
  }
  public void move() {
    //targetX = target.getX();
    //targetY = target.getY();
    targetX = mouseX;
    targetY = mouseY;
    //calculates target angle and prevents wraparound
    if(myCenterX > targetX) targetAngle = PI+Math.atan((myCenterY-targetY)/(myCenterX-targetX));
    if(myCenterX < targetX) targetAngle = Math.atan((myCenterY-targetY)/(myCenterX-targetX));
    myRad = myPointDirection*PI/180;
    if(targetAngle-myRad > PI) targetAngle-=2*PI;
    if(targetAngle-myRad < -PI) targetAngle+=2*PI;
    accelerate(1);
    
    //calculates angle difference, rotates missile proportional to
    double delta = 0.5*Math.abs(targetAngle - myRad + Math.random()*0.1-0.05);
    if(delta > 0.25) delta = 0.25;
    if(myRad < targetAngle) this.turn(delta*180/PI);
    if(myRad > targetAngle) this.turn(delta*180/PI);
    //prevents wraparound
    if(myRad > 2*PI) this.turn(-360);
    if(myRad < -2*PI) this.turn(360);
    super.move();
    
    double overCap = Math.sqrt(Math.pow(myXspeed,2)+Math.pow(myYspeed,2))/speedCap;
      if (overCap > 1) {
        myXspeed*=(1/overCap);
        myYspeed*=(1/overCap);
      }
    
  }
  public void show() {
    fill(#FF00FF);
    ellipse((float)myCenterX,(float)myCenterY,30,30);
  }
}

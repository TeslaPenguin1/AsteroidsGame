class Missile extends Projectile {
  private Floater tgt;
  private double targetX, targetY, targetAngle, myRad;
  public Missile(Spaceship ship, Floater t) {
    tgt = t;
    timer = -1;
    speedCap = 30;
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myXspeed = ship.getXspeed();
    myYspeed = ship.getYspeed();
    myPointDirection = ship.getPointDirection();
    damage = 10;
    corners = 5;
    xCorners = new int[]{-4, 0, 6, 0,-4};
    yCorners = new int[]{-2,-2, 0, 2, 2};
    myFillColor = #FFFFFF;
    myStrokeColor = #FFFFFF;
  }
  public void target(Floater t) {
    tgt = t;
  }
  
  /***
  HOW TO FIX MOVEMENT ISSUE??
    0. figure out how to do target tracking through wraparounds
    1. calculate own trajectory
    2. calculate target trajectory + intercept
    3. find diff btwn intercept line and trajectory
    4. target angle = something proportional to diff
  Thus, the missile will slowly turn towards its target as it improves its vector.
  
  ***/
  
  public void move() {
    if(tgt != null) {
      targetX = tgt.getX();
      targetY = tgt.getY();
      //calculates target angle and prevents wraparound
      if(myCenterX > targetX) targetAngle = PI+Math.atan((myCenterY-targetY)/(myCenterX-targetX));
      if(myCenterX < targetX) targetAngle = Math.atan((myCenterY-targetY)/(myCenterX-targetX));
      myRad = myPointDirection*PI/180;
      if(targetAngle-myRad > PI) targetAngle-=2*PI;
      if(targetAngle-myRad < -PI) targetAngle+=2*PI;
      accelerate(1);
      
      //calculates angle difference, rotates missile proportional to
      double delta = 0.5*Math.abs(targetAngle - myRad + Math.random()*0.1-0.05);
      if(delta > 0.5) delta = 0.5;
      if(myRad > targetAngle) this.turn(-delta*180/PI);
      if(myRad < targetAngle) this.turn(delta*180/PI);
      //prevents wraparound
      if(myRad > 2*PI) this.turn(-360);
      if(myRad < -2*PI) this.turn(360);
      super.move();
    }  
    else {
      accelerate(1);
      super.move();
    }
  }
}

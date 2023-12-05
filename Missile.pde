class Missile extends Projectile {
  private Floater tgt;
  private ArrayList arr;
  private double targetX, targetY, interceptAngle, velAngle, commandAngle, myRad;
  public Missile(Spaceship ship, Floater t, ArrayList a) {
    debug = false;
    tgt = t;
    arr = a;
    timer = 250;
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
    myFillColor = #000000;
    myStrokeColor = #FFFFFF;
    size = 10;
    accelerate(3);
    explodeSize = 50;
    remove = true;
    explosive = true;
  }
  public void target(Floater t) {
    tgt = t;
  }
  
  
  public void move() {
    if(tgt != null) {
      
      
      //offsets target coordinates if approach thru screen overlap would be faster
      if (Math.abs(tgt.getX()+width-myCenterX) < Math.abs(tgt.getX()-myCenterX)) targetX = tgt.getX()+width;
      else if (Math.abs(myCenterX+width-tgt.getX()) < Math.abs(myCenterX-tgt.getX())) targetX = tgt.getX()-width;
      else targetX = tgt.getX();
      if (Math.abs(tgt.getY()+height-myCenterY) < Math.abs(tgt.getY()-myCenterY)) targetY = tgt.getY()+height;
      else if (Math.abs(myCenterY+height-tgt.getY()) < Math.abs(myCenterY-tgt.getY())) targetY = tgt.getY()-height;
      else targetY = tgt.getY();
      
      double dist = Math.sqrt(Math.pow(myCenterX - targetX, 2) + Math.pow(myCenterY - targetY, 2));
      double speed = Math.sqrt(Math.pow(myXspeed, 2) + Math.pow(myYspeed, 2));
      double timeToIntercept = -speed+Math.sqrt(Math.pow(speed,2) + 2*dist);
      
      targetX+=tgt.getXspeed()*timeToIntercept;
      targetY+=tgt.getYspeed()*timeToIntercept;
      
      //calculates angles
      if(myCenterX > targetX) interceptAngle = PI+Math.atan((myCenterY-targetY)/(myCenterX-targetX));
      if(myCenterX <= targetX) interceptAngle = Math.atan((myCenterY-targetY)/(myCenterX-targetX));
      if(myXspeed > 0) velAngle = Math.atan(myYspeed/myXspeed);
      if(myXspeed < 0) velAngle = PI+Math.atan(myYspeed/myXspeed);
      
      commandAngle = 2*interceptAngle-velAngle;
      myRad = myPointDirection*PI/180;

      
      if(velAngle-interceptAngle > PI/2) commandAngle = velAngle+PI;
      if(velAngle-interceptAngle < -PI/2) commandAngle = velAngle-PI;
      
      
      if(commandAngle-myRad > PI) commandAngle-=2*PI;
      if(commandAngle-myRad < -PI) commandAngle+=2*PI;      
      
      
      /***
      DEBUG LINES
      ***/
      if (debug) {
        strokeWeight(3);
        translate((float)myCenterX, (float)myCenterY);
        rotate((float)interceptAngle);
        stroke(#FF0000);
        line(0,0,50,0);
        rotate(-1*(float)interceptAngle);
        rotate((float)velAngle);
        stroke(#00FF00);
        line(0,0,50,0);
        rotate(-1*(float)velAngle);
        rotate((float)commandAngle);
        stroke(#0000FF);
        line(0,0,50,0);
        rotate(-1*(float)commandAngle);
        rotate((float)myRad);
        stroke(#FFFFFF);
        line(0,0,25,0);
        rotate(-1*(float)myRad);
        translate(-1*(float)myCenterX, -1*(float)myCenterY);
        strokeWeight(1);
      }
      
      double angleDiff = commandAngle - myRad;
      //calculates angle difference, rotates missile proportional to
      double angleMax = 0.5;
      double delta = angleMax*Math.abs(angleDiff);
      if(delta > angleMax) delta = angleMax;
      if(myRad > commandAngle) this.turn(-delta*180/PI);
      if(myRad < commandAngle) this.turn(delta*180/PI);
      //prevents wraparound
      if(myRad > 2*PI) this.turn(-360);
      if(myRad < -2*PI) this.turn(360);
      
      
      if (angleDiff < 0.5) accelerate(1);
      
      if(arr.contains(tgt) == false) tgt = null;
      super.move();
    }  
    else {
      accelerate(1);
      super.move();
    }
  }
}

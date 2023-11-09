class Spaceship extends Floater  
{   
    protected int hyperTimer, showFire, shootTimer;
    protected double speedCap;
    public Spaceship() {
      corners = 4;
      xCorners = new int[]{-8, 16, -8, -2};
      yCorners = new int[]{-8, 0,   8,  0};
      myFillColor = #000000;
      myStrokeColor = #FFFFFF;
      myCenterX = 600;
      myCenterY = 400;
      myXspeed = myYspeed = myPointDirection = 0;
      hyperTimer = 0;
      showFire = 2;
      speedCap = 20;
      damage = 12;
      health = maxHealth = 30;
    }
    public void tick() {
      //decrement the cooldown
      if (hyperTimer > 0) hyperTimer--;
      if (shootTimer > 0) shootTimer--;
      double overCap = Math.sqrt(Math.pow(myXspeed,2)+Math.pow(myYspeed,2))/speedCap;
      if (overCap > 1) {
        myXspeed*=(1/overCap);
        myYspeed*=(1/overCap);
      }
    }
    public void hyperspace() {
      if (hyperTimer == 0) {
        myCenterX = 1000*Math.random();
        myCenterY = 1000*Math.random();
        myXspeed = myYspeed = 0;
        myPointDirection = 360*Math.random();
        hyperTimer = 300;
      }
    }
    public void shoot(ArrayList proj) {
      if (shootTimer == 0) {
        proj.add(new Bullet(this));
        shootTimer = 6;
      }
    }
    public int getHyperTimer() {
      return hyperTimer;
    }
    public void show(boolean accelerate, boolean deccelerate) {
      translate((float)myCenterX, (float)myCenterY);
      float dRadians = (float)(myPointDirection*(Math.PI/180));
      rotate(dRadians);
      
      if (accelerate || deccelerate) {
        //set up engine fire
        fill(myFillColor);
        stroke(myStrokeColor);
        
        
        if (showFire > 0) {
          if (accelerate) triangle(0,-5,0,5,-12,0);
          if (deccelerate) {
            triangle(11,-2,6,-3,15,-7);
            triangle(11,2,6,3,15,7);
          }
        }
        if (showFire == -1) showFire = 3;
        showFire--;
        
        
      }
      rotate(-1*dRadians);      
      fill(#00FF00);
      noStroke();
      quad(-20,17,-20,22,-20+(health*40/maxHealth),22,-20+(health*40/maxHealth),17);
      strokeWeight(0.25);
      noFill();
      stroke(255);
      quad(-20,17,-20,22,20,22,20,17);

      translate(-1*(float)myCenterX, -1*(float)myCenterY);
      strokeWeight(1.5);
      super.show();
    }
}

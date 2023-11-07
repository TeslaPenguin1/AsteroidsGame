class Spaceship extends Floater  
{   
    protected int hyperTimer, showFire, shootTimer;
    public Spaceship() {
      corners = 4;
      xCorners = new int[]{-8, 16, -8, -2};
      yCorners = new int[]{-8, 0,   8,  0};
      myFillColor = #000000;
      myStrokeColor = #FFFFFF;
      myCenterX = 600;
      myCenterY = 450;
      myXspeed = myYspeed = myPointDirection = 0;
      hyperTimer = 0;
      showFire = 2;
    }
    public void tick() {
      //decrement the cooldown
      if (hyperTimer > 0) hyperTimer--;
      if (shootTimer > 0) shootTimer--;
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
        shootTimer = 10;
      }
    }
    public int getHyperTimer() {
      return hyperTimer;
    }
    public void show(boolean accelerate, boolean deccelerate) {
      if (accelerate || deccelerate) {
        //set up engine fire
        fill(myFillColor);
        stroke(myStrokeColor);
        translate((float)myCenterX, (float)myCenterY);
        float dRadians = (float)(myPointDirection*(Math.PI/180));
        rotate(dRadians);
        
        if (showFire > 0) {
          if (accelerate) triangle(0,-5,0,5,-12,0);
          if (deccelerate) {
            triangle(11,-2,6,-3,15,-7);
            triangle(11,2,6,3,15,7);
          }
        }
        if (showFire == -1) showFire = 3;
        showFire--;
        
        rotate(-1*dRadians);
        translate(-1*(float)myCenterX, -1*(float)myCenterY);
      }
      super.show();
    }
}

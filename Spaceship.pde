class Spaceship extends Floater  
{   
    protected int hyperTimer, shootTimer, timer, targetNum, targetTimer, invTimer,
        recovRate, shieldBar, shieldRot, shieldCorners, shieldFill, shieldStroke, shieldHealth,
        mineAmt, missileAmt, lightningAmt;
    protected int[] shieldXCorners, shieldYCorners;
    protected double targetAngle;
    protected boolean shielded, shieldBroken, targetLocked;
    protected String weapon;
    public final static int MAX_HEALTH = 30;
    public final static int SHIELD_MAX = 60;
    protected Floater tgt;
    public Spaceship() {
      corners = 11;
      xCorners = new int[]{-10, -8, -4,  4,  8, 16, 8, 4, -4, -8, -10};
      yCorners = new int[]{-2,  -8, -8, -4, -3, 0,  3, 4, 8,  8,  2};
      shieldCorners = 8;
      shieldXCorners = new int[] {27,(int)Math.sqrt(364.5),0,-(int)Math.sqrt(364.5),-27,-(int)Math.sqrt(364.5),0,(int)Math.sqrt(364.5)};
      shieldYCorners = new int[] {0,(int)Math.sqrt(364.5),27,(int)Math.sqrt(364.5),0,-(int)Math.sqrt(364.5),-27,-(int)Math.sqrt(364.5)};
      myFillColor = #000000;
      myStrokeColor = #FFFFFF;
      shieldFill = color(0,255,255,127);
      shieldStroke = #00FFFF;
      myCenterX = 600;
      myCenterY = 400;
      myXspeed = myYspeed = myPointDirection = 0;
      hyperTimer = invTimer = timer = 0;
      speedCap = 20;
      damage = 12;
      health = MAX_HEALTH;
      shieldHealth = SHIELD_MAX;
      shielded = false;
      shieldBroken = false;
      shieldBar = #00FFFF;
      recovRate = 2;
      targetNum = -1;
      tgt = null;
      weapon = "Guns";
      mineAmt = missileAmt = lightningAmt = 5;
    }
    public void tick() {
      //decrement the cooldown
      if (hyperTimer > 0) hyperTimer--;
      if (shootTimer > 0) shootTimer--;
      timer++;
      shieldRot++;
      if (invTimer > 0) invTimer--;
      if (shielded && timer % 3 == 0) shieldHealth--;
      if (!shielded && shieldHealth < SHIELD_MAX && timer % recovRate == 0) shieldHealth++;
      if (shieldHealth == SHIELD_MAX) {
        shieldBroken = false;
        shieldBar = #00FFFF;
        recovRate = 2;
      }
      if (shieldHealth < 0) {
        shieldHealth = 0;
        shielded = false;
        shieldBroken = true;
        shieldBar = #FF0000;
        recovRate = 4;
      }
      
    }
    
    public void deselect() {
      tgt = null;
      targetNum = -1;
    }
    public void targetDecrement(int num) {
      if (num < targetNum) targetNum--;
    }
    
    public void target(ArrayList arr, boolean cmd1, boolean cmd2) {
      if (targetTimer <= 0 && arr.size() >= 1) {
        if (cmd1) {
          targetTimer = 10;
          targetNum++;
          if (targetNum > arr.size()-1) targetNum = 0;
        }
        if (cmd2) {
          targetTimer = 10;
          targetNum--;
          if (targetNum < 0) targetNum = arr.size()-1;
        }
      }
      if (targetTimer > 0) targetTimer--;

      if (targetNum >= 0) {
        tgt = (Floater)arr.get(targetNum);
        
        if(myCenterX > tgt.getX()) targetAngle = PI+Math.atan((myCenterY-tgt.getY())/(myCenterX-tgt.getX()));
        if(myCenterX < tgt.getX()) targetAngle = Math.atan((myCenterY-tgt.getY())/(myCenterX-tgt.getX()));
        double radAngle = (myPointDirection*PI/180)%(2*PI);
        if(targetAngle-radAngle > PI) targetAngle-=2*PI;
        if(targetAngle-radAngle < -PI) targetAngle+=2*PI;
        
        
        if (radAngle-0.5 < targetAngle && radAngle+0.5 > targetAngle) fill(#FF0000);
        else fill(#FF8800);
        
        translate((float)tgt.getX(), (float)tgt.getY());
        ellipse(0,0,100,100);
        translate(-1*(float)tgt.getX(), -1*(float)tgt.getY());
      }
    }
    
    public Floater getTarget() {
      return tgt;
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
    public void setWeapon(String wep) {
      weapon = wep;
    }
    
    /***
    Valid weapons:
    Guns            (done)
    Ion Wave
    Point Defense
    Missiles        (done)
    Mines           (done)
    Lightning
    ***/
    public void doDebug(boolean d) {
      super.doDebug(d);
    }
    public void shoot(ArrayList proj, ArrayList arr) {
      if (shootTimer == 0) {
        switch (weapon) {
        case "Guns":
          proj.add(new Bullet(this));
          shootTimer = 6;
          break;
            
        case "Point Defense":
          break;
          
        case "Ion Wave":
          break;
          
        case "Missiles":
          if (missileAmt != 0) {
            proj.add(new Missile(this,tgt,arr));
            shootTimer = 30;
            missileAmt--;
          }
          break;
        
        case "Mines":
          if (mineAmt != 0) {
            proj.add(new Mine(this));
            shootTimer = 30;
            mineAmt--;
          }
          break;
        
        case "Lightning":
          if (lightningAmt != 0) {
            
          }
        }
      }
    }
    public void setShield(boolean s) {
      if (!shieldBroken) shielded = s;
      else shielded = false;
    }
    public int shieldSize() {
      if (shielded) return 25;
      else return 5;
    }
    public int getHyperTimer() {
      return hyperTimer;
    }
    public void hit(int dmg) {
      if (shielded) shieldHealth -= dmg;
      else if (invTimer == 0) {
        super.hit(dmg);
        invTimer = 100;
      }
    }
    public void show(boolean accelerate, boolean deccelerate) {
      translate((float)myCenterX, (float)myCenterY);
      float dRadians = (float)(myPointDirection*(Math.PI/180));
      rotate(dRadians);
      
      if (invTimer > 0 && (int)(timer/10) % 2 == 0) myStrokeColor = #999999;
      else myStrokeColor = #FFFFFF;
      
      if (accelerate || deccelerate) {
        //set up engine fire
        fill(myFillColor);
        stroke(myStrokeColor);
        
        
        if (timer/2 % 2 == 0) {
          if (accelerate) triangle(-5,-5,-5,5,-16,0);
          if (deccelerate) {
            triangle(11,-2,6,-3,15,-7);
            triangle(11,2,6,3,15,7);
          }
        }
        
        
      }
      rotate(-1*dRadians);      
      fill(#00FF00);
      noStroke();
      quad(-20,17,-20,22,-20+(health*40/MAX_HEALTH),22,-20+(health*40/MAX_HEALTH),17);
      fill(shieldBar);
      quad(-20,25,-20,28,-20+(shieldHealth*40/SHIELD_MAX),28,-20+(shieldHealth*40/SHIELD_MAX),25);
      strokeWeight(0.25);
      noFill();
      stroke(255);
      quad(-20,17,-20,22,20,22,20,17);
      
      translate(-1*(float)myCenterX, -1*(float)myCenterY);
     
      
      strokeWeight(1.5);
      super.show();
      if (shielded) {
        translate((float)myCenterX, (float)myCenterY);
        float sRadians = (float)(shieldRot*(Math.PI/180));
        rotate(sRadians);
        
        fill(shieldFill);
        stroke(shieldStroke);
        beginShape();
        for (int nI = 0; nI < shieldCorners; nI++)
        {
          vertex(shieldXCorners[nI], shieldYCorners[nI]);
        }
        endShape(CLOSE);
      
        rotate(-1*sRadians);
        translate(-1*(float)myCenterX, -1*(float)myCenterY);
      }
      
      if (debug) {
        invTimer = -1;
        missileAmt = mineAmt = lightningAmt = -1;
        noFill();
        strokeWeight(3);
        stroke(#00FF00);
        ellipse((float)myCenterX,(float)myCenterY,(float)shieldSize()*2,(float)shieldSize()*2);
        strokeWeight(1);
      }
    }
}

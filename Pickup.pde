class Pickup extends Floater {
  private String type;
  private double rotSpeed;
  private int myInnerColor, myInnerStroke;
  private int n;
  public Pickup(int t, double x, double y) {
    switch (t) {
      case 0:
        type = "Repair";
        break;
        
      case 1:
        type = "Shield";
        break;
      
      case 2:
        type = "Weapon";
        break;
        
      case 3:
        type = "Missiles";
        break;
      
      case 4:
        type = "Mines";
        break;
      
      case 5:
        type = "Lightning";
        break;
    }
    myCenterX = x;
    myCenterY = y;
    corners = 6;
    n = 12;
    int nx = (int)(n/2.0);
    int ny = (int)(n*Math.sqrt(3)/2.0);
    xCorners = new int[]{n,nx,-nx,-n,-nx,nx};
    yCorners = new int[]{0,ny,ny,0,-ny,-ny};
    myFillColor = #228888;
    myStrokeColor = color(0,0); 
    myInnerColor = #44DDDD;
    myInnerStroke = #88FFFF;
    myXspeed = 1.5*Math.random()-0.75;
    myYspeed = 0.5*Math.random()+0.5;
    rotSpeed = 5*Math.random()-2.5;
  }
  
  public void move() {
    //in main game loop, removes if wraps around edges
    myCenterX += myXspeed;
    myCenterY += myYspeed;
    myPointDirection += rotSpeed;
  }
  
  public int getRadius() {
    return n;
  }
  
  public String getType() {
    return type;
  }
  
  public void show() {
    super.show();
    translate((float)myCenterX,(float)myCenterY);
    
    if (debug) {
      noFill();
      strokeWeight(3);
      stroke(#FF00FF);
      ellipse(0,0,(float)getRadius()*2,(float)getRadius()*2);
      strokeWeight(1);
    }
    
    rotate((float)(myPointDirection*(Math.PI/180)));
    fill(myInnerColor);
    stroke(myInnerStroke);

    
    switch(type) {
      case "Repair":
        scale(0.8);
        beginShape();
        vertex(n*3/5.0,n/7.0);
        vertex(n*3/5.0,-n/7.0);
        vertex(n/7.0,-n/7.0);
        vertex(n/7.0,-n*3/5.0);
        vertex(-n/7.0,-n*3/5.0);
        vertex(-n/7.0,-n/7.0);
        vertex(-n*3/5.0,-n/7.0);
        vertex(-n*3/5.0,n/7.0);
        vertex(-n/7.0,n/7.0);
        vertex(-n/7.0,n*3/5.0);
        vertex(n/7.0,n*3/5.0);
        vertex(n/7.0,n/7.0);
        endShape(CLOSE);
        scale(1/0.8);
        break;
        
      case "Mines":
        scale(0.8);
        beginShape();
        vertex(n*2/3.0,0);
        vertex(n*4/15.0,n*4/15.0);
        vertex(0,n*2/3.0);
        vertex(-n*4/15.0,n*4/15.0);
        vertex(-n*2/3.0,0);
        vertex(-n*4/15.0,-n*4/15.0);
        vertex(0,-n*2/3.0);
        vertex(n*4/15.0,-n*4/15.0);
        endShape(CLOSE);
        scale(1/0.8);
        break;
      
      case "Missiles":
        scale(0.8);
        beginShape();
        vertex(-n/2.0,-n/4.0);
        vertex(0,-n/4.0);
        vertex(3*n/4.0,0);
        vertex(0,n/4.0);
        vertex(-n/2.0,n/4.0);
        endShape(CLOSE);
        scale(1/0.8);
        break;
        
      case "Lightning":
        break;
      
      case "Shield":
        rotate(PI/2);
        beginShape();
        vertex(0,n*0.5);
        vertex(n*0.2,n*0.4);
        vertex(n*0.3,n*0.35);
        vertex(n*0.25,-n*0.2);
        vertex(n*0.2,-n*0.3);
        vertex(0,-n*0.5);
        vertex(-n*0.2,-n*0.3);
        vertex(-n*0.25,-n*0.2);
        vertex(-n*0.3,n*0.35);
        vertex(-n*0.2,n*0.4);
        endShape(CLOSE);
        rotate(PI/-2);
        break;
      
      case "Weapon":
        beginShape();
        float nMax = n*0.5;
        float nOut = (float)Math.sqrt(Math.pow(nMax,2)/2);
        float nInL = n*0.2;
        float nInS = (float)(nInL*Math.tan(PI/8));
        vertex(0,nMax);
        vertex(nInS,nInL);
        vertex(nOut,nOut);
        vertex(nInL,nInS);
        vertex(nMax,0);
        vertex(nInL,-nInS);
        vertex(nOut,-nOut);
        vertex(nInS,-nInL);
        vertex(0,-nMax);
        vertex(-nInS,-nInL);
        vertex(-nOut,-nOut);
        vertex(-nInL,-nInS);
        vertex(-nMax,0);
        vertex(-nInL,nInS);
        vertex(-nOut,nOut);
        vertex(-nInS,nInL);
        endShape(CLOSE);
        break;
      
    }
    rotate(-1*(float)(myPointDirection*(Math.PI/180)));
    translate(-1*(float)myCenterX,-1*(float)myCenterY);
  }
}

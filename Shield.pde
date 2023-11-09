class Shield extends Floater {
  private int rotSpeed;
  public Shield (Floater obj) {
    corners = 8;
    
    xCorners = new int[] {25,(int)Math.sqrt(312.5),0,-(int)Math.sqrt(312.5),-25,-(int)Math.sqrt(312.5),0,(int)Math.sqrt(312.5)};
    yCorners = new int[] {0,(int)Math.sqrt(312.5),25,(int)Math.sqrt(312.5),0,-(int)Math.sqrt(312.5),-25,-(int)Math.sqrt(312.5)};
    
    myCenterX = obj.getX();
    myCenterY = obj.getY();
    myXspeed = myYspeed = myPointDirection = 0;
    myFillColor = color(0,255,255,127);
    myStrokeColor = #00FFFF;
    health = 40;
    
  }
  public void move(Floater obj) {
    myCenterX = obj.getX();
    myCenterY = obj.getY();
    myPointDirection += rotSpeed;
  }
}

class Star //note that this class does NOT extend Floater
{
  private int myX, myY;
  public Star() {
    myX = (int)(Math.random()*1200);
    myY = (int)(Math.random()*900);
  }
  public void show() {
    fill(255);
    noStroke();
    ellipse(myX,myY,3,3);
  }
}

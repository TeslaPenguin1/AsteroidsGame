class Notif {
  private String message;
  private double myX, myY;
  private int timer, myColor;
  public final static int MAX_TIME = 128;
  public Notif(String str, double x, double y) {
    message = str;
    myX = x;
    myY = y;
    timer = MAX_TIME;
    myColor = 255;
  }
  public void popup() {
    myColor = color(255,timer*255/MAX_TIME);
    fill(myColor);
    textSize(15);
    textAlign(CENTER);
    text(message,(float)myX,(float)myY);
    myY--;
    timer--;
  }
  public int getTimer() {
    return timer;
  }
}

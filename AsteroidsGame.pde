Spaceship enterprise = new Spaceship();
boolean upPressed;
boolean downPressed;
boolean leftPressed;
boolean rightPressed;
boolean sPressed;
Star[] stars = new Star[1000];
Asteroid[] asty = new Asteroid[10];

public void setup() {
  size(1000, 1000);
  background(0);
  upPressed = downPressed = leftPressed = rightPressed = sPressed = false;
  for(int i = 0; i < stars.length; i++) stars[i] = new Star();
  for(int i = 0; i < asty.length; i++) asty[i] = new Asteroid();
  strokeWeight(1.5);
}
public void draw() {
  fill(0);
  noStroke();
  quad(0,0,0,height,width,height,width,0);
  for(int i = 0; i < stars.length; i++) stars[i].show();
  fill(#FF0000);
  quad(10,10,10,20,10+enterprise.getHyperTimer(),20,10+enterprise.getHyperTimer(),10);
  enterprise.move();
  enterprise.show(upPressed,downPressed);
  enterprise.tick();
  for(int i = 0; i < asty.length; i++) {
    asty[i].move();
    asty[i].show();
  }
  if (keyPressed) {
    if (upPressed) enterprise.accelerate(0.1);
    if (downPressed) enterprise.accelerate(-0.1);
    if (leftPressed) enterprise.turn(-4);
    if (rightPressed) enterprise.turn(4);
    if (sPressed) enterprise.hyperspace();
  }
}

public void keyPressed() {
  if (keyCode == UP) upPressed = true;
  if (keyCode == DOWN) downPressed = true;
  if (keyCode == LEFT) leftPressed = true;
  if (keyCode == RIGHT) rightPressed = true;
  if (key == 's') sPressed = true;
}

public void keyReleased() {
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
  if (key == 's') sPressed = false;
}

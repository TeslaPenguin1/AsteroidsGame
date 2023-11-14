Spaceship enterprise = new Spaceship();
boolean doGame = true;
boolean upPressed, downPressed, leftPressed, rightPressed, sPressed, spacePressed, dPressed;
Star[] stars = new Star[1000];
ArrayList <Asteroid> asts;
ArrayList <Bullet> bullets;

/*** TODO

Visuals
- Better looking ship
- Hyperspace Animation
- Better UI
- Score/winning?

Abilities
- Alt utilities
  - Chaff (not currently important)
- Alt basic weapons
  - Wave
  - PDC
- Special weapons
  - Missile
  - Mines
  - Lightning
  
Enemies
- KKV + KKV Cluster
- Snakes
- Enemy Ship (V2 Ultrakill)

***/


public void setup() {
  size(1200, 800);
  background(0);
  upPressed = downPressed = leftPressed = rightPressed = sPressed = spacePressed = false;
  asts = new ArrayList <Asteroid>();
  bullets = new ArrayList <Bullet>();
  for (int i = 0; i < 20; i++) asts.add(new Asteroid(2, Math.random()*1200,0));
  for(int i = 0; i < stars.length; i++) stars[i] = new Star();
  strokeWeight(1.5);
}
public void draw() {
  fill(0);
  noStroke();
  quad(0,0,0,height,width,height,width,0);
  for(int i = 0; i < stars.length; i++) stars[i].show();
  if (doGame) {
    fill(#FF0000);
    quad(10,10,10,20,10+enterprise.getHyperTimer(),20,10+enterprise.getHyperTimer(),10);
    enterprise.move();
    enterprise.show(upPressed,downPressed);
    enterprise.tick();
    enterprise.setShield(dPressed);
  }
  for(int i = asts.size() - 1; i >= 0; i--) {
    asts.get(i).move();
    asts.get(i).show();
    if(asts.get(i).collides(enterprise,asts.get(i).getRadius() + enterprise.shieldSize())) {
      enterprise.hit(asts.get(i).getDamage());
      asts.remove(i);
      if(enterprise.getHealth() <= 0) doGame = false;
    }
  }
  
  for(int i = bullets.size() - 1; i >= 0; i--) {
    if (bullets.get(i).getTimer() == 0) {
      bullets.remove(i);
      break;
    }
    bullets.get(i).move();
    bullets.get(i).show();
    for(int j = asts.size() - 1; j >= 0; j--) {
      if (asts.get(j).collides(bullets.get(i),asts.get(j).getRadius())) {
        asts.get(j).hit(bullets.get(i).getDamage());
        bullets.remove(i);
        if (asts.get(j).getHealth() <= 0) {
          if(asts.get(j).getSize() > 0) asts.get(j).split(asts);
          asts.remove(j);
        }
        break;
      }
    }
  }
  if (keyPressed) {
    if (upPressed) enterprise.accelerate(0.1);
    if (downPressed) enterprise.accelerate(-0.1);
    if (leftPressed) enterprise.turn(-4);
    if (rightPressed) enterprise.turn(4);
    if (sPressed) enterprise.hyperspace();
    if (spacePressed) enterprise.shoot(bullets);
  }
}

public void keyPressed() {
  if (keyCode == UP) upPressed = true;
  if (keyCode == DOWN) downPressed = true;
  if (keyCode == LEFT) leftPressed = true;
  if (keyCode == RIGHT) rightPressed = true;
  if (key == 's') sPressed = true;
  if (key == ' ') spacePressed = true;
  if (key == 'd') dPressed = true;
}

public void keyReleased() {
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
  if (key == 's') sPressed = false;
  if (key == ' ') spacePressed = false;
  if (key == 'd') dPressed = false;
}

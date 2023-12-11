Spaceship enterprise = new Spaceship();
boolean doGame = true;
boolean debug = false;
boolean upPressed, downPressed, leftPressed, rightPressed, sPressed, spacePressed, 
    dPressed, shiftPressed, ctrlPressed, wPressed, xPressed, cPressed, mPressed;
Star[] stars = new Star[1000];
ArrayList <Asteroid> asts;
ArrayList <Projectile> bullets;
ArrayList <Pickup> powerups;

/*** TODO

Game Mechanics
- Targeting
  - Target-Locking
  - Better UI
- Special Weapon Limits
  - UI
- Score
  - Enemies
- Pickups
  - Ammo
  - Health
  - Powerups

Abilities
- Utilities
  - Hyperspace
    - Animation
    - Better UI
  - Chaff (not currently important)
- Basic weapons
  - Ion Wave
  - Point Defense
- Special weapons
  - Lightning
  
Enemies
- UFOs
- KKV + KKV Cluster
- Snakes
- Enemy Ship (V2 Ultrakill)

***/


public void setup() {
  size(1280, 760);
  background(0);
  asts = new ArrayList <Asteroid>();
  bullets = new ArrayList <Projectile>();
  powerups = new ArrayList <Pickup>();
  for (int i = 0; i < 20; i++) asts.add(new Asteroid(2, Math.random()*1280,0));
  //for (int i = 0; i < 2; i++) powerups.add(new Pickup("Repair", Math.random()*1280,0));
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
    enterprise.target(asts, shiftPressed, ctrlPressed);
    enterprise.show(upPressed,downPressed);
    enterprise.tick();
    enterprise.setShield(dPressed);
    enterprise.doDebug(debug);
    if(asts.size() == 0) for (int i = 0; i < 20; i++) asts.add(new Asteroid(2, Math.random()*1280,0));
  }
  for(int i = asts.size() - 1; i >= 0; i--) {
    asts.get(i).move();
    asts.get(i).show();
    asts.get(i).doDebug(debug);
    if(asts.get(i).collides(enterprise,asts.get(i).getRadius() + enterprise.shieldSize())) {
      enterprise.hit(asts.get(i).getDamage());
      if (enterprise.getTarget() == asts.get(i)) enterprise.deselect();
      else enterprise.targetDecrement(i);
      asts.remove(i);
    }
  }
  
  for(int i = powerups.size() - 1; i >= 0; i--) {
    powerups.get(i).move();
    powerups.get(i).show();
  }
  
  for(int i = bullets.size() - 1; i >= 0; i--) {
    if (bullets.get(i).getTimer() == 0) {
      bullets.remove(i);
      break;
    }
    if (bullets.get(i).damagesSelf() && bullets.get(i).collides(enterprise, enterprise.shieldSize() + bullets.get(i).getSize())) enterprise.hit(bullets.get(i).getDamage()/10);
    bullets.get(i).move();
    bullets.get(i).show();
    bullets.get(i).doDebug(debug);
    for(int j = asts.size() - 1; j >= 0; j--) {
      if (asts.get(j).collides(bullets.get(i),asts.get(j).getRadius()+bullets.get(i).getSize())) {
        asts.get(j).hit(bullets.get(i).getDamage());
        bullets.get(i).explode(bullets);
        if (bullets.get(i).getRemove()) bullets.remove(i);
        if (asts.get(j).getHealth() <= 0) {
          if(asts.get(j).getSize() > 0) asts.get(j).split(asts);
          if (enterprise.getTarget() == asts.get(j)) enterprise.deselect();
          else enterprise.targetDecrement(j);
          asts.remove(j);
        }
        break;
      }
    }
  }
  
  if(enterprise.getHealth() <= 0) doGame = false;
  
  if (keyPressed) {
    if (upPressed) enterprise.accelerate(0.1);
    if (downPressed) enterprise.accelerate(-0.1);
    if (leftPressed) enterprise.turn(-4);
    if (rightPressed) enterprise.turn(4);
    if (sPressed) enterprise.hyperspace();
    if (spacePressed) enterprise.shoot(bullets, asts);
    if (wPressed) enterprise.setWeapon("Guns");
    if (xPressed) enterprise.setWeapon("Missiles");
    if (cPressed) enterprise.setWeapon("Mines");
    if (mPressed) asts.add(new Asteroid(2, Math.random()*1280,0));
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
  if (keyCode == SHIFT) shiftPressed = true;
  if (keyCode == CONTROL) ctrlPressed = true;
  if (key == 'w') wPressed = true;
  if (key == 'x') xPressed = true;
  if (key == 'c') cPressed = true;
  
  if (key == 'm') mPressed = true;
  if (key == 'n') debug = true;
}

public void keyReleased() {
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
  if (key == 's') sPressed = false;
  if (key == ' ') spacePressed = false;
  if (key == 'd') dPressed = false;
  if (keyCode == SHIFT) shiftPressed = false;
  if (keyCode == CONTROL) ctrlPressed = false;
  if (key == 'w') wPressed = false;
  if (key == 'c') cPressed = false;
  
  if (key == 'x') xPressed = false;
  if (key == 'm') mPressed = false;
}

Spaceship enterprise = new Spaceship();
boolean doGame = true;
boolean debug = false;
boolean upPressed, downPressed, leftPressed, rightPressed, sPressed, spacePressed, 
    dPressed, shiftPressed, ctrlPressed, wPressed, xPressed, cPressed, mPressed;
Star[] stars = new Star[1000];
ArrayList <Asteroid> asts;
ArrayList <Projectile> bullets;
ArrayList <Pickup> powerups;
int timedLoop;
int score;

/*** TODO

Game Mechanics
- Targeting
  - Target-Locking?
  - Better UI
- Game Loop
  - Score
  - Enemies
- Pickups 
  - Pity system?
  - UI
    - Appearance for Lightning
    - Better ammo count
    - Pickup messages (e.g. "+7 HP" or "+2 [mines icon]"

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
  for(int i = 0; i < stars.length; i++) stars[i] = new Star();
  strokeWeight(1.5);
  timedLoop = 0;
}
public void draw() {
  fill(0);
  noStroke();
  quad(0,0,0,height,width,height,width,0);
  timedLoop++;
  
  fill(#FFFFFF);
  textAlign(RIGHT);
  textSize(50);
  text(score,width-20,50);
  
  //My Personal High Score: 38600 (update every test)
  
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
  
  if (timedLoop % 1000 == 0) {
    powerups.add(new Pickup((int)(Math.random()*5), Math.random()*1280,-5));
  }
  
  for(int i = asts.size() - 1; i >= 0; i--) {
    asts.get(i).move();
    asts.get(i).show();
    asts.get(i).doDebug(debug);
    if(asts.get(i).collides(enterprise,asts.get(i).getRadius() + enterprise.shieldSize())) {
      enterprise.hit(asts.get(i).getDamage());
      if (enterprise.getTarget() == asts.get(i)) enterprise.deselect();
      else enterprise.targetDecrement(i);
      score += 100*(3-asts.get(i).getSize());
      asts.remove(i);
    }
  }
  
  for(int i = powerups.size() - 1; i >= 0; i--) {
    powerups.get(i).move();
    powerups.get(i).show();
    powerups.get(i).doDebug(debug);
    if (powerups.get(i).getX() > width + 30 || powerups.get(i).getX() < -30 || powerups.get(i).getY() > height + 30 || powerups.get(i).getY() < -30) {
      powerups.remove(i);
      break;
    }
    if(powerups.get(i).collides(enterprise,powerups.get(i).getRadius() + enterprise.shieldSize())) {
      switch(powerups.get(i).getType()) {
        case "Repair":
          enterprise.hit(-1*(int)(Math.random()*6)-5);
          break;
        
        case "Mines":
          enterprise.restock("Mines",(int)(Math.random()*3)+1);
          break;
        
        case "Missiles":
          enterprise.restock("Missiles",(int)(Math.random()*3)+2);
          break;
        
        case "Lightning":
          enterprise.restock("Lightning",(int)(Math.random()*2)+1);
          break;
        
        case "Shield":
          enterprise.shieldBoost((int)(Math.random()*50)+400);
          break;
          
        case "Weapon":
          enterprise.setMult(2,(int)(Math.random()*50)+300);
          break;
      }
      score += 500;
      powerups.remove(i);
    }
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
        asts.get(j).hit(bullets.get(i).getDamage()*enterprise.getMult());
        bullets.get(i).explode(bullets);
        if (bullets.get(i).canRemove()) bullets.remove(i);
        if (asts.get(j).getHealth() <= 0) {
          if(asts.get(j).getSize() > 0) asts.get(j).split(asts);
          if (enterprise.getTarget() == asts.get(j)) enterprise.deselect();
          else enterprise.targetDecrement(j);
          score += 100*(3-asts.get(j).getSize());
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
  if (key == 's' || key == 'S') sPressed = true;
  if (key == ' ') spacePressed = true;
  if (key == 'd' || key == 'D') dPressed = true;
  if (keyCode == SHIFT) shiftPressed = true;
  if (keyCode == CONTROL) ctrlPressed = true;
  if (key == 'w' || key == 'W') wPressed = true;
  if (key == 'x' || key == 'X') xPressed = true;
  if (key == 'c' || key == 'C') cPressed = true;
  
  if (key == 'm' || key == 'M') mPressed = true;
  if (key == 'n' || key == 'N') debug = true;
}

public void keyReleased() {
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
  if (key == 's' || key == 'S') sPressed = false;
  if (key == ' ') spacePressed = false;
  if (key == 'd' || key == 'D') dPressed = false;
  if (keyCode == SHIFT) shiftPressed = false;
  if (keyCode == CONTROL) ctrlPressed = false;
  if (key == 'w' || key == 'W') wPressed = false;
  if (key == 'x' || key == 'X') xPressed = false;
  if (key == 'c' || key == 'C') cPressed = false;
  
  if (key == 'm' || key == 'M') mPressed = false;
}


/*
Ship, PlayerShip, EnemyShip
 */

class Ship {
  protected float positionX, positionY;
  protected float velocity;
  protected float size;
  protected float rate;
  protected color shipColor;
  protected int hp, maxHp;
  protected PImage img;
  protected AudioPlayer shotSE;

  BulletManager bulletManager;

  Ship(float _positionX, float _positionY, float _velocity, float _size, float _rate, color _shipColor, int _hp, PImage _img, AudioPlayer _shotSE) {
    positionX  = _positionX;
    positionY  = _positionY;
    velocity   = _velocity;
    size       = _size;
    rate       = _rate;
    shipColor  = _shipColor;
    hp = maxHp = _hp;
    img        = _img;
    shotSE     = _shotSE;

    bulletManager = new BulletManager(30, _shipColor);
  }

  public void move() {
    bulletManager.move();
  }

  public void render() {
    image(img, positionX, positionY, size, size);
    bulletManager.render();
    fill(shipColor);
    rect(positionX, positionY + 15, size*hp/maxHp, size/10);
  }

  public void shoot() {
  }

  public void damage() {
    hp--;
  }

  public boolean isAlive() {
    boolean flag = true;
    if (hp <= 0) {
      flag = false;
    }
    return flag;
  }

  public PVector returnBulletPosition(int i) {
    PVector position = bulletManager.returnBulletPosition(i);
    return position;
  }
}

class PlayerShip extends Ship {
  private float preMillis = 0;

  PlayerShip(float _positionX, float _positionY, float _velocity, float _size, float _rate, color _shipColor, int _hp, PImage _img, AudioPlayer _shotSE) {
    super(_positionX, _positionY, _velocity, _size, _rate, _shipColor, _hp, _img, _shotSE);
  }

  public void move() {
    float dirX = (float)(positionX - mouseX) / dist(mouseX, mouseY, positionX, positionY);
    float dirY = (float)(positionY - mouseY) / dist(mouseX, mouseY, positionX, positionY);
    PVector direction = new PVector(dirX, dirY);
    if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
      positionX -= direction.x*velocity;
      positionY -= direction.y*velocity;
    }
    if (mousePressed == true && (millis() - preMillis) > rate*1000) {
      shoot(direction);
      preMillis = millis();
    }
    super.move();
  }

  public void render() {
    pushMatrix();
    translate(positionX, positionY);
    float rad = atan((mouseY - positionY)/(mouseX - positionX));
    if (mouseX < positionX)rad += PI;

    fill(shipColor);
    rect(0, 15, size*hp/maxHp, size/10);

    rotate(rad + PI/4);
    image(img, 0, 0, size, size);
    popMatrix();

    bulletManager.render();
  }

  public void shoot(PVector direction) {
    shotSE.rewind();
    shotSE.play();
    bulletManager.shoot(positionX, positionY, -20*direction.x, -20*direction.y);
  }

  public PVector returnPosition() {
    PVector direction = new PVector(positionX, positionY);
    return direction;
  }
}

class EnemyShip extends Ship {
  private float preMillis = 0;

  EnemyShip(float _positionX, float _positionY, float _velocity, float _size, float _rate, color _shipColor, int _hp, PImage _img, AudioPlayer _shotSE) {
    super(_positionX, _positionY, _velocity, _size, _rate, _shipColor, _hp, _img, _shotSE);
  }

  public void move(float targetX, float targetY, int isChase) {
    PVector direction = new PVector();
    direction.add(enemyAI(targetX, targetY, positionX, positionY));
    positionX -= direction.x*velocity*isChase*random(0.5, 1.5);
    positionY -= direction.y*velocity*isChase*random(0.5, 1.5);

    if ((millis() - preMillis) > rate*1000) {
      shoot(direction);
      preMillis = millis();
    }

    super.move();
  }

  public void shoot(PVector direction) {
    shotSE.rewind();
    shotSE.play();
    bulletManager.shoot(positionX, positionY, -direction.x+random(-0.5, 0.5), -direction.y+random(-0.5, 0.5));
  }

  public PVector enemyAI(float bulletX, float bulletY, float shipX, float shipY) {
    float dirX = (float) (shipX - bulletX) / dist(bulletX, bulletY, shipX, shipY);
    float dirY = (float) (shipY - bulletY) / dist(bulletX, bulletY, shipX, shipY);
    PVector direction = new PVector(dirX, dirY);

    return direction;
  }
}

class BossEnemyShip extends EnemyShip {
  private float preMillis = 0;

  BossEnemyShip(float _positionX, float _positionY, float _velocity, float _size, float _rate, color _shipColor, int _hp, PImage _img, AudioPlayer _shotSE) {
    super(_positionX, _positionY, _velocity, _size, _rate, _shipColor, _hp, _img, _shotSE);
  }

  public void move(float targetX, float targetY, int isChase) {
    PVector direction = new PVector();
    direction.add(enemyAI(targetX, targetY, positionX, positionY));
    positionX -= direction.x*velocity*isChase;
    positionY -= direction.y*velocity*isChase;

    if ((millis() - preMillis) > rate*1000) {
      preMillis = millis();
    } else if ((millis() - preMillis) > rate*900 && (millis() - preMillis) % 10 < 5) {
      shoot(direction);
    }

    super.move();
  }

  public void shoot(PVector direction) {
    float rand = random(1.0, 3.0);
    bulletManager.shoot(positionX, positionY, -direction.x*rand, -direction.y*rand);
  }
}

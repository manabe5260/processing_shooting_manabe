
/*
Ship, PlayerShip, EnemyShip
 */

class Ship {
  protected float positionX, positionY;
  protected float velocity;
  protected float sizeX, sizeY;
  protected color shipColor;
  protected int hp, maxHp;
  protected PImage img;

  BulletManager bulletManager;

  Ship(float _positionX, float _positionY, float _velocity, float _sizeX, float _sizeY, color _shipColor, int _hp, PImage _img) {
    positionX  = _positionX;
    positionY  = _positionY;
    velocity   = _velocity;
    sizeX      = _sizeX;
    sizeY      = _sizeY;
    shipColor  = _shipColor;
    hp = maxHp = _hp;
    img        = _img;

    bulletManager = new BulletManager(30, _shipColor);
  }

  public void move() {
    bulletManager.move();
  }

  public void render() {
    image(img, positionX, positionY, sizeX, sizeY);
    bulletManager.render();
    fill(shipColor);
    rect(positionX, positionY + 15, sizeX*hp/maxHp, sizeY/10);
  }

  public void shoot() {
  }

  public void damage() {
    hp--;
    println(hp);
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
  PlayerShip(float _positionX, float _positionY, float _velocity, float _sizeX, float _sizeY, color _shipColor, int _hp, PImage _img) {
    super(_positionX, _positionY, _velocity, _sizeX, _sizeY, _shipColor, _hp, _img);
  }

  public void move() {
    float dirX = (float)(positionX - mouseX) / dist(mouseX, mouseY, positionX, positionY);
    float dirY = (float)(positionY - mouseY) / dist(mouseX, mouseY, positionX, positionY);
    PVector direction = new PVector(dirX, dirY);
    if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
      positionX -= direction.x*velocity;
      positionY -= direction.y*velocity;
    }
    if (mousePressed == true) {
      shoot(direction);
    }
    super.move();
  }

  public void render() {
    pushMatrix();
    translate(positionX, positionY);
    float rad = atan((mouseY - positionY)/(mouseX - positionX));
    if (mouseX < positionX)rad += PI;

    fill(shipColor);
    rect(0, 15, sizeX*hp/maxHp, sizeY/10);

    rotate(rad + PI/4);
    image(img, 0, 0, sizeX, sizeY);
    popMatrix();

    bulletManager.render();
  }

  public void shoot(PVector direction) {
    bulletManager.shoot(positionX, positionY, -20*direction.x, -20*direction.y);
  }

  public PVector returnPosition() {
    PVector direction = new PVector(positionX, positionY);
    return direction;
  }
}

class EnemyShip extends Ship {

  EnemyShip(float _positionX, float _positionY, float _velocity, float _sizeX, float _sizeY, color _shipColor, int _hp, PImage _img) {
    super(_positionX, _positionY, _velocity, _sizeX, _sizeY, _shipColor, _hp, _img);
  }

  public void move(float targetX, float targetY, int isChase) {
    PVector direction = new PVector();
    direction.add(enemyAI(targetX, targetY, positionX, positionY));
    positionX -= direction.x*velocity*isChase;
    positionY -= direction.y*velocity*isChase;

    if ((millis()%1000)/100 == 0) {
      shoot(direction);
    }

    super.move();
  }

  public PVector enemyAI(float bulletX, float bulletY, float shipX, float shipY) {
    float dirX = (float) random(0.0, 1.0) * (shipX - bulletX) / dist(bulletX, bulletY, shipX, shipY);
    float dirY = (float) random(0.0, 1.0) * (shipY - bulletY) / dist(bulletX, bulletY, shipX, shipY);
    PVector direction = new PVector(dirX, dirY);

    return direction;
  }

  public void shoot(PVector direction) {
    bulletManager.shoot(positionX, positionY, -direction.x+random(-1.0, 1.0), -direction.y+random(-1.0, 1.0));
  }
}
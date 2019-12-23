
class Ship {
  protected float positionX, positionY;
  protected float velocityX, velocityY;
  protected float sizeX, sizeY;
  protected color shipColor;

  BulletManager bulletManager;

  Ship(float _positionX, float _positionY, float _velocityX, float _velocityY, float _sizeX, float _sizeY, color _shipColor) {
    positionX = _positionX;
    positionY = _positionY;
    velocityX = _velocityX;
    velocityY = _velocityY;
    sizeX = _sizeX;
    sizeY = _sizeY;
    shipColor = _shipColor;

    bulletManager = new BulletManager(30);
  }

  public void move() {
    bulletManager.move();
  }

  public void render() {
    fill(shipColor);
    rect(positionX, positionY, sizeX, sizeY);
    bulletManager.render();
  }

  public void shoot() {
  }
  
  public PVector returnBulletPosition(int i){
    PVector position = bulletManager.returnBulletPosition(i);
    return position;
  }
}

class PlayerShip extends Ship {
  PlayerShip(float _positionX, float _positionY, float _velocityX, float _velocityY, float _sizeX, float _sizeY, color _shipColor) {
    super(_positionX, _positionY,_velocityX, _velocityY, _sizeX, _sizeY, _shipColor);
  }

  public void move() {
    if (keyPressed == true && key == 'w') {
      positionY -= velocityY;
    }
    if (keyPressed == true && key == 'a') {
      positionX -= velocityX;
    }
    if (keyPressed == true && key == 's') {
      positionY += velocityY;
    }
    if (keyPressed == true && key == 'd') {
      positionX += velocityX;
    }
    if (keyPressed == true && key == ' ') {
      shoot();
    }
    super.move();
  }

  public void shoot() {
    bulletManager.shoot(positionX, positionY, 20, 0);
  }

  public PVector returnPosition() {
    PVector direction = new PVector(positionX, positionY);
    return direction;
  }
}

class EnemyShip extends Ship { 
  EnemyShip(float _positionX, float _positionY, float _velocityX, float _velocityY, float _sizeX, float _sizeY, color _shipColor) {
    super(_positionX, _positionY, _velocityX, _velocityY, _sizeX, _sizeY, _shipColor);
  }

  public void move(float targetX, float targetY, int isChase) {
    PVector direction = new PVector();
    direction.add(enemyAI(targetX, targetY, positionX, positionY));
    positionX -= direction.x*velocityX*isChase;
    positionY -= direction.y*velocityY*isChase;

    if ((millis()%1000)/100 == 0) {
      shoot();
    }
    
    super.move();
  }

  public PVector enemyAI(float bulletX, float bulletY, float shipX, float shipY) {
    float dirX = (float)(shipX - bulletX) / dist(bulletX, bulletY, shipX, shipY);
    float dirY = (float)(shipY - bulletY) / dist(bulletX, bulletY, shipX, shipY);
    PVector direction = new PVector(dirX, dirY);
    
    return direction;
  }

  public void shoot() {
    float rad = random(-3.0, 3.0);
    bulletManager.shoot(positionX, positionY, -10*cos(rad), -10*sin(rad));
  }
}
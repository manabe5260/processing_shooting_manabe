
class Ship {
  float positionX = width/2, positionY = height/2;
  float velocityX, velocityY;
  float sizeX, sizeY;
  color shipColor;

  BulletManager bulletManager;

  Ship(float _velocityX, float _velocityY, float _sizeX, float _sizeY, color _shipColor) {
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

  private void shoot() {
  }
}

class PlayerShip extends Ship {

  PlayerShip(float _velocityX, float _velocityY, float _sizeX, float _sizeY, color _shipColor){
    super(_velocityX, _velocityY, _sizeX, _sizeY, _shipColor);
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
      bulletManager.shoot(positionX, positionY, 20, 0);
    }
    super.move();
  }
}

class EnemyShip {
}
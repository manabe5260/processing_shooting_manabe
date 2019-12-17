
class Bullet {
  private float positionX, positionY;
  private float velocityX, velocityY;
  private float radius;
  private color bulletColor;
  private int startTime;

  Bullet(float _radius, color _bulletColor) {
    radius = _radius;
    bulletColor = _bulletColor;
  }

  public void move() {
    positionX += velocityX;
    positionY += velocityY;
  }

  public void render() {
    fill(bulletColor);
    ellipse(positionX, positionY, radius, radius);
  }

  public void shoot(float _positionX, float _positionY, float _velocityX, float _velocityY) {
    positionX = _positionX;
    positionY = _positionY;
    velocityX = _velocityX;
    velocityY = _velocityY;
    startTime = millis();
  }
  
  public float returnPositionX(){
    return positionX;
  }
}

class PlayerBullet extends Bullet {
  PlayerBullet(float _radius, color _bulletColor) {
    super(_radius, _bulletColor);
  }
  public void shoot(float _positionX, float _positionY, float _velocityX, float _velocityY) {
    super.shoot(_positionX, _positionY, _velocityX, _velocityY);
  }
}

class EnemyBullet {
}
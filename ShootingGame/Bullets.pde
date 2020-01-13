
/*
Bullet
弾丸
 */

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

  public void render(color _color) {
    fill(_color);
    ellipse(positionX, positionY, radius, radius);
  }

  public void shoot(float _positionX, float _positionY, float _velocityX, float _velocityY) {
    positionX = _positionX;
    positionY = _positionY;
    velocityX = _velocityX;
    velocityY = _velocityY;
    startTime = millis();
  }
  //ヒット判定用
  public PVector returnPosition() {
    PVector position = new PVector(positionX, positionY);
    return position;
  }
}

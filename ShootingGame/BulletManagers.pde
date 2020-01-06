
/*
BulletManager
 */

class BulletManager {
  private Bullet[] bulletArray;
  private int maxBullets;
  private color bulletColor;

  BulletManager(int _maxBullets, color _bulletColor) {
    maxBullets = _maxBullets;
    bulletColor = _bulletColor;
    
    bulletArray = new Bullet[maxBullets];
  }

  public void move() {
    for ( int i = 0; i < maxBullets; i++ ) {
      if ( bulletArray[i] != null ) {
        bulletArray[i].move();
        reset(i);
      }
    }
  }

  public void render() {
    for ( int i = 0; i < maxBullets; i++ ) {
      if ( bulletArray[i] != null ) {
        bulletArray[i].render(bulletColor);
      }
    }
  }

  public void shoot( float _positionX, float _positionY, float _velocityX, float _velocityY ) {
    for ( int i = 0; i < maxBullets; i++ ) {
      if ( bulletArray[i] == null ) {    
        bulletArray[i] = new Bullet(10, color(0, 255, 0));
        bulletArray[i].shoot(_positionX, _positionY, _velocityX, _velocityY);
        break;
      }
    }
  }

  private void reset(int i) {
    if ( bulletArray[i].returnPosition().x < 0 || width < bulletArray[i].returnPosition().x ) {
      bulletDelete(i);
    } else if ( bulletArray[i].returnPosition().y < 0 || height < bulletArray[i].returnPosition().y ) {
      bulletDelete(i);
    }
  }

  public void bulletDelete(int i) {
    bulletArray[i]=null;
  }

  public PVector returnBulletPosition(int i) {
    PVector position = new PVector();
    position = bulletArray[i].returnPosition();
    return position;
  }
}
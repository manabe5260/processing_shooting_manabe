class BulletManager {
  private Bullet[] bulletArray;
  int maxBullets;

  BulletManager(int _maxBullets) {
    maxBullets = _maxBullets;
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
        bulletArray[i].render();
      }
    }
  }

  public void shoot( float _positionX, float _positionY, float _velocityX, float _velocityY ) {
    for ( int i = 0; i < maxBullets; i++ ) {
      if ( bulletArray[i] == null ) {    
        bulletArray[i] = new Bullet(5, color(0, 255, 0));
        bulletArray[i].shoot(_positionX, _positionY, _velocityX, _velocityY);
        break;
      }
    }
  }

  private void reset(int i) {
    if ( bulletArray[i].returnPositionX() < 0 || width < bulletArray[i].returnPositionX() ) {
      bulletArray[i]=null;
    }
  }
}
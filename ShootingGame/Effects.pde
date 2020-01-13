
/*
EffectManager, Effects
エフェクトの制御
 */

class EffectManager {
  private Effect[] effectArray;
  private int maxEffects;

  final private float lifeTime = 300;

  EffectManager(int _maxEffects) {
    maxEffects  = _maxEffects;
    effectArray = new Effect[maxEffects];
  }

  public void move() {
    for ( int i = 0; i < maxEffects; i++ ) {
      if ( effectArray[i] != null ) {
        effectArray[i].move();
        reset(i);
      }
    }
  }

  public void render() {
    for ( int i = 0; i < maxEffects; i++ ) {
      if ( effectArray[i] != null ) {
        effectArray[i].render();
      }
    }
  }
  //発生
  public void shoot( float _positionX, float _positionY, color _effectColor) {
    for ( int i = 0; i < maxEffects; i++ ) {
      if ( effectArray[i] == null ) {
        effectArray[i] = new Effect(_positionX, _positionY, _effectColor, millis());
        break;
      }
    }
  }
  //時間で消去
  private void reset(int i) {
    if ((millis() - effectArray[i].returnTime()) > lifeTime) {
      effectDelete(i);
    }
  }

  public void effectDelete(int i) {
    effectArray[i]=null;
  }
}

class Effect {
  final private int maxEffects = 10;
  final private float radius = 6;

  private PVector[] position = new PVector[maxEffects];
  private PVector[] velocity = new PVector[maxEffects];
  private int startTime;
  private color effectColor;

  Effect(float _positionX, float _positionY, color _effectColor, int _startTime) {
    for (int i = 0; i < maxEffects; i++) {
      position[i] = new PVector(_positionX, _positionY);
      velocity[i] = new PVector(random(-20, 20), random(-20, 20));
    }
    startTime = _startTime;
    effectColor = _effectColor;
  }

  public void move() {
    for (int i = 0; i < maxEffects; i++) {
      position[i].add(velocity[i].x, velocity[i].y);
    }
  }

  public void render() {
    fill(effectColor);
    for (int i = 0; i < maxEffects; i++) {
      ellipse(position[i].x, position[i].y, radius, radius);
    }
  }

  public int returnTime() {
    return startTime;
  }
}

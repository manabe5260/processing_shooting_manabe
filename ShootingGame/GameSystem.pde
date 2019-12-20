
class GameSystem {
  private PlayerShip playerShip;
  private EnemyShip[] enemyShip = new EnemyShip[3];

  GameSystem() {
    playerShip = new PlayerShip(width/3, height/2, 5, 5, 10, 10, color(255, 0, 0));
    enemyShip[0] = new EnemyShip(width*2/3, height/2, 1, 1, 15, 15, color(150, 0, 230));
    enemyShip[1] = new EnemyShip(width*2/3, height*1/3, 1, 1, 15, 15, color(100, 0, 240));
    enemyShip[2] = new EnemyShip(width*2/3, height*2/3, 1, 1, 15, 15, color(0, 0, 255));
  }

  public void move() {
    playerShip.move();
    PVector position = new PVector();
    position.add(playerShip.returnPosition());

    for (int i=0; i<3; i++) {
      enemyShip[i].move(position.x, position.y, 1);
    }
  }

  public void render() {
    playerShip.render();
    enemyShip[0].render();
    for (int i=0; i<3; i++) {
      enemyShip[i].render();
    }
  }

  public void hitBullet() {
  }

  public void score() {
  }

  public void isGameOver() {
  }
}
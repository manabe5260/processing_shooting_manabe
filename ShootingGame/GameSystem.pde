
class GameSystem {
  private float playerRadius = 5;
  private float enemyRadius = 5;
  private int score = 0;
  private String status = "playing";

  final int maxEnemyShips = 3;

  private PlayerShip playerShip;
  private EnemyShip[] enemyShip = new EnemyShip[maxEnemyShips]; 

  GameSystem() {
    playerShip = new PlayerShip(width/3, height/2, 5, 5, 10, 10, color(255, 0, 0));
    enemyShip[0] = new EnemyShip(width*2/3, height/2, 1, 1, 15, 15, color(150, 0, 230));
    enemyShip[1] = new EnemyShip(width*2/3, height*1/3, 1, 1, 15, 15, color(100, 0, 240));
    enemyShip[2] = new EnemyShip(width*2/3, height*2/3, 1, 1, 15, 15, color(0, 0, 255));
  }

  public void move() {
    PVector position = new PVector(0, 0);

    if (playerShip != null) {
      playerShip.move();
      position.add(playerShip.returnPosition());
    }
    for (int i=0; i<maxEnemyShips; i++) {
      if (enemyShip[i] != null)enemyShip[i].move(position.x, position.y, 1);
    }

    hitBullet();
  }

  public void render() {
    if (playerShip != null)playerShip.render();
    for (int i=0; i<maxEnemyShips; i++) {
      if (enemyShip[i] != null)enemyShip[i].render();
    }
    fill(255);
    textSize(30);
    text(score, width/10, height/10);
  }

  public void hitBullet() {
    //playerShip-EnemyShipBullet
    for (int i=0; i<maxEnemyShips; i++) {
      for (int j=0; j<30; j++) {
        if (playerShip != null && enemyShip[i] != null && enemyShip[i].bulletManager.bulletArray[j] != null) {
          if (dist(playerShip.positionX, playerShip.positionY, enemyShip[i].returnBulletPosition(j).x, enemyShip[i].returnBulletPosition(j).y) < playerRadius) {
            enemyShip[i].bulletManager.bulletDelete(j);
            playerShip=null;
          }
        }
      }
    }

    //enemyShip-playerBullet
    for (int i=0; i<maxEnemyShips; i++) {
      for (int j=0; j<30; j++) {
        if (playerShip != null && enemyShip[i] != null && playerShip.bulletManager.bulletArray[j] != null) {
          if (dist(enemyShip[i].positionX, enemyShip[i].positionY, playerShip.returnBulletPosition(j).x, playerShip.returnBulletPosition(j).y) < enemyRadius) {
            playerShip.bulletManager.bulletDelete(j);
            enemyShip[i]=null;
            score++;
          }
        }
      }
    }
  }

  public void scoreUpdate() {
  }

  public String isGameOver() {
    if (playerShip == null) {
      status = "lose";
    } else if (score == maxEnemyShips) {
      status = "win";
    }
    return status;
  }

  public void saveResults() {
    memory.writeMemory(score, status);
  }
}
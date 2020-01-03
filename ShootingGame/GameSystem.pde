
/*
GameSystem
 */

class GameSystem {
  final float playerRadius = 30, enemyRadius = 30;
  final int playerHp = 6, enemyHp = 10;
  private int score = 0;
  private String status = "playing";

  final int maxEnemyShips = 3;

  private PlayerShip playerShip;
  private EnemyShip[] enemyShip = new EnemyShip[maxEnemyShips]; 

  GameSystem(PImage _playerImage, PImage _enemyImage1, PImage _enemyImage2, PImage _enemyImage3) {
    playerShip = new PlayerShip(width/4, height/2, 2, 50, 50, color(255, 150, 150), playerHp, _playerImage);
    enemyShip[0] = new EnemyShip(width/2, height/4, 2, 50, 50, color(150, 200, 230), enemyHp, _enemyImage1);
    enemyShip[1] = new EnemyShip(width*3/4, height/2, 2, 50, 50, color(100, 200, 240), enemyHp, _enemyImage2);
    enemyShip[2] = new EnemyShip(width/2, height*3/4, 2, 50, 50, color(0, 200, 255), enemyHp, _enemyImage3);
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
    isAlives();
  }

  public void render() {
    if (playerShip != null)playerShip.render();
    for (int i=0; i<maxEnemyShips; i++) {
      if (enemyShip[i] != null)enemyShip[i].render();
    }
    fill(255);
    textSize(50);
    text(score, width/10, height/10);
  }

  public void hitBullet() {
    //playerShip-EnemyShipBullet
    for (int i=0; i<maxEnemyShips; i++) {
      for (int j=0; j<30; j++) {
        if (playerShip != null && enemyShip[i] != null && enemyShip[i].bulletManager.bulletArray[j] != null) {
          if (dist(playerShip.positionX, playerShip.positionY, enemyShip[i].returnBulletPosition(j).x, enemyShip[i].returnBulletPosition(j).y) < playerRadius) {
            enemyShip[i].bulletManager.bulletDelete(j);
            playerShip.damage();
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
            enemyShip[i].damage();
            score++;
          }
        }
      }
    }
  }

  public void scoreUpdate() {
  }

  public void isAlives() {
    if (playerShip != null && playerShip.isAlive() == false) {
      playerShip = null;
    }
    for (int i = 0; i < 3; i++) {
      if (enemyShip[i] != null && enemyShip[i].isAlive() == false) {
        enemyShip[i] = null;
      }
    }
  }

  public String isGameOver() {
    if (playerShip == null) {
      status = "lose";
    } else if (score >= maxEnemyShips * enemyHp) {
      status = "win";
    }
    return status;
  }

  public void saveResults() {
    memory.writeMemory(score, status);
  }
}
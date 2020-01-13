
/*
GameSystem
ゲームのシステム
 */

class GameSystem {
  final float playerRadius = 30, enemyRadius = 30;
  final int playerHp = 6, enemyHp = 4;
  final int maxEnemyShips = 5;

  private int score = 0;
  private String status = "playing";

  private PlayerShip playerShip;
  private EnemyShip[] enemyShip = new EnemyShip[maxEnemyShips]; 

  private AudioPlayer playerHitSE, enemyHitSE;
  private EffectManager effectManager;

  GameSystem(PImage _playerImage, PImage _enemyImage1, PImage _enemyImage2, PImage _enemyImage3, 
    AudioPlayer playerShotSE, AudioPlayer enemyShotSE, AudioPlayer _playerHitSE, AudioPlayer _enemyHitSE) {
    playerShip   = new PlayerShip(width/4, height/2, 3, 50, 0.3, color(255, 150, 150), playerHp, _playerImage, playerShotSE);
    enemyShip[0] = new EnemyShip(width/2, height/4, 0.7, 50, 1, color(150, 230, 200), enemyHp, _enemyImage1, enemyShotSE);
    enemyShip[1] = new EnemyShip(width*3/4, height/2, 0.8, 50, 1, color(100, 240, 200), enemyHp, _enemyImage2, enemyShotSE);
    enemyShip[2] = new EnemyShip(-width/2, height/4, 0.9, 50, 1, color(150, 230, 200), enemyHp, _enemyImage1, enemyShotSE);
    enemyShip[3] = new EnemyShip(width*3/4, -height/2, 1.0, 50, 1, color(100, 240, 200), enemyHp, _enemyImage2, enemyShotSE);   
    enemyShip[4] = new BossEnemyShip(width*2, height*3/4, 1.8, 100, 1, color(0, 255, 200), enemyHp, _enemyImage3, enemyShotSE);

    playerHitSE = _playerHitSE;
    enemyHitSE  = _enemyHitSE;

    effectManager = new EffectManager(5);
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

    effectManager.move();
  }

  public void render() {
    if (playerShip != null) {
      playerShip.render();
    }
    for (int i=0; i<maxEnemyShips; i++) {
      if (enemyShip[i] != null)enemyShip[i].render();
    }
    fill(255);
    textSize(50);
    text(score, width/10, height/10);

    effectManager.render();
  }

  public void hitBullet() {
    for (int i=0; i<maxEnemyShips; i++) {
      for (int j=0; j<30; j++) {
        //playerShip-EnemyShipBullet
        if (playerShip != null && enemyShip[i] != null && enemyShip[i].bulletManager.bulletArray[j] != null) {
          if (dist(playerShip.positionX, playerShip.positionY, enemyShip[i].returnBulletPosition(j).x, 
            enemyShip[i].returnBulletPosition(j).y) < playerRadius) {
            enemyShip[i].bulletManager.bulletDelete(j);
            playerShip.damage();
            playerHitSE.rewind();
            playerHitSE.play();
            effectManager.shoot(playerShip.positionX, playerShip.positionY, color(240, 100, 100));
          }
        }

        //enemyShip-playerBullet
        if (playerShip != null && enemyShip[i] != null && playerShip.bulletManager.bulletArray[j] != null) {
          if (dist(enemyShip[i].positionX, enemyShip[i].positionY, playerShip.returnBulletPosition(j).x, 
            playerShip.returnBulletPosition(j).y) < enemyRadius) {
            playerShip.bulletManager.bulletDelete(j);
            enemyShip[i].damage();
            enemyHitSE.rewind();
            enemyHitSE.play();
            effectManager.shoot(enemyShip[i].positionX, enemyShip[i].positionY, color(100, 240, 100));
            score++;
          }
        }
      }
    }
  }//hitBullet()

  public void scoreUpdate() {
  }
  
  //機体の生存
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
  
  //終了判定
  public String isGameOver() {
    if (playerShip == null) {
      status = "lose";
    } else if (score >= maxEnemyShips * enemyHp) {
      status = "win";
    }
    return status;
  }
  //スコア保存(シーンをまたいでの受け渡し)
  public void saveResults() {
    memory.writeMemory(score, status);
  }
}

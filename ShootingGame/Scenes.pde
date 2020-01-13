
/*
Scene, TitleScene, GameScene, EndScene
シーンたち
 */

class Scene {
  public String flag = null;

  public void initialize() {
  }
  public void move() {
  }
  public void render() {
  }
  public void finalize() {
  }
  public String returnFlag() {
    return flag;
  }
}

class TitleScene extends Scene {
  private PImage titleImage, titleLogo;
  private AudioPlayer bgm;

  public void initialize() {
    titleImage = loadImage("image/titleImage.jpg");
    titleLogo  = loadImage("image/titleLogo.png");

    bgm = minim.loadFile("music/bgm1.mp3");
    bgm.play();
  }

  public void move() {
    if (mousePressed == true && mouseY > height*3/5) {
      flag = "game";
    }
  }

  public void render() {
    image(titleImage, width/2, height/2, width, height);

    image(titleLogo, width/2, height*2/5, width*2/3 + random(-width/20, width/20), height/6 + random(-height/20, height/20));
    textSize(height/7);
    text("push Here", width/2, height*4/5);
  }

  public void finalize() {
    titleImage = titleLogo = null;
    bgm.pause();
    bgm.rewind();
  }
}

class GameScene extends Scene {
  private PImage backGroundImage, playerImage, enemyImage1, enemyImage2, enemyImage3;
  private AudioPlayer bgm, playerShotSE, enemyShotSE, playerHitSE, enemyHitSE;
  private GameSystem gameSystem;

  public void initialize() {
    backGroundImage = loadImage("image/titleImage.jpg");
    playerImage = loadImage("image/player.png");
    enemyImage1 = loadImage("image/ufo1.png");
    enemyImage2 = loadImage("image/ufo3.png");
    enemyImage3 = loadImage("image/ufo2.png");
    bgm = minim.loadFile("music/bgm2.mp3");
    playerShotSE = minim.loadFile("music/shot4.mp3");
    enemyShotSE = minim.loadFile("music/shot1.mp3");
    playerHitSE = minim.loadFile("music/hit1.mp3");
    enemyHitSE = minim.loadFile("music/hit2.mp3");

    bgm.play();

    gameSystem  = new GameSystem(playerImage, enemyImage1, enemyImage2, enemyImage3, playerShotSE, enemyShotSE, playerHitSE, enemyHitSE);
  }

  public void move() {
    gameSystem.move();
    if (gameSystem.isGameOver() != "playing" || (keyPressed == true && key == 'f') ) {
      flag = "end";
    }
  }

  public void render() {
    image(backGroundImage, width/2, height/2, width, height);
    gameSystem.render();
  }

  public void finalize() {
    backGroundImage = playerImage = enemyImage1 = enemyImage2 = enemyImage3 = null;
    gameSystem.saveResults();
    bgm.pause();
    bgm.rewind();
  }
}

class EndScene extends Scene {
  private PImage endImage;
  private AudioPlayer bgm;

  public void initialize() {
    endImage = loadImage("image/backGroundImage.jpg");
    bgm = minim.loadFile("music/bgm3.mp3");
    bgm.play();
  }

  public void move() {
    if (keyPressed == true && key == ENTER) {
      flag = "title";
    }
  }

  public void render() {
    image(endImage, width/2, height/2, width, height);

    fill(255, 100, 100);    
    if (memory.readStatus() == "lose")fill(100, 100, 255);
    textSize(random(0.8, 1.2)*height/4);
    text("You " + memory.readStatus(), width/2, height*2/5);

    fill(255);
    textSize(height/5);
    text("score : " + memory.readScore(), width/2, height*3/5);

    textSize(height/7);
    text("press RETURN", width/2, height*4/5);
  }

  public void finalize() {
    endImage = null;
    bgm.pause();
    bgm.rewind();
  }
}

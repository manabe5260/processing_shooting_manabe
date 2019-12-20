
class Scene {
  public boolean flagExit = false;

  public void initialize() {
  }
  public void move() {
  }
  public void render() {
  }
  public void finalize() {
  }
  public boolean returnFlag() {
    return flagExit;
  }
}

class TitleScene extends Scene {
  private PImage titleImage;

  public void initialize() {
    titleImage = loadImage("titleImage.png");
  }

  public void move() {
    if (keyPressed == true && key == ENTER) {
      flagExit = true;
    }
  }

  public void render() {
    image(titleImage, width/2, height/2, width, height);
  }

  public void finalize() {
    titleImage = null;
  }
}

class GameScene extends Scene {
  private GameSystem gameSystem;

  public void initialize() {
    gameSystem = new GameSystem();
  }

  public void move() {
    gameSystem.move();
  }

  public void render() {
    gameSystem.render();
  }
}

class EndScene extends Scene {
}
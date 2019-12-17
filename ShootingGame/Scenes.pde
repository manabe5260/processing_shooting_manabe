
class Scene {
  private boolean flagExit = false;

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
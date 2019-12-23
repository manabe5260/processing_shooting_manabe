
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
  private PImage titleImage;

  public void initialize() {
    titleImage = loadImage("titleImage.png");
  }

  public void move() {
    if (keyPressed == true && key == ENTER) {
      flag = "game";
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
    if (gameSystem.isGameOver() != "playing" || (keyPressed == true && key == ENTER) ) {
      flag = "end";
    }
  }

  public void render() {
    gameSystem.render();
  }

  public void finalize() {
    gameSystem.saveResults();
  }
}

class EndScene extends Scene {
  private PImage endImage;

  public void initialize() {
    endImage = loadImage("endImage.jpg");
  }

  public void move() {
    if (keyPressed == true && key == ENTER) {
      flag = "title";
    }
  }

  public void render() {
    image(endImage, width/2, height/2, width, height);
    
    fill(255, 0, 0);    
    if(memory.readStatus() == "lose")fill(0, 0, 255);
    textSize(height/4);
    text("You " + memory.readStatus(), width/2, height*2/5);
    
    fill(0);
    textSize(height/5);
    text("score : " + memory.readScore(), width/2, height*3/5);
    
    textSize(height/7);
    text("press ENTER", width/2, height*4/5);
  }

  public void finalize() {
    endImage = null;
  }
}
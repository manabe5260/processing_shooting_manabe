
public static Memory memory;
Scene currentScene;

void setup() {
  size(1200, 900);
  background(0);

  imageMode(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER);

  smooth();

  currentScene = new TitleScene();
  currentScene.initialize();
  
  memory = new Memory();
}

void draw() {
  background(0);

  currentScene.move();
  currentScene.render();

  if ( currentScene.returnFlag() != null ) {
    currentScene.finalize();
    if (currentScene.returnFlag() == "title") {
      currentScene = new TitleScene();
    } else if (currentScene.returnFlag() == "game") {
      currentScene = new GameScene();
    } else if (currentScene.returnFlag() == "end") {
      currentScene = new EndScene();
    }    
    currentScene.initialize();
  }
}
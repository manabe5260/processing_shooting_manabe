
public static Memory memory;
Scene currentScene;

void setup() {
  size(800, 600);
  background(0);

  imageMode(CENTER);
  rectMode( CENTER );
  ellipseMode( CENTER ); 
  textAlign( CENTER );

  smooth ();

  currentScene = new GameScene();
  currentScene.initialize();
}

void draw() {
  background(0);
  
  currentScene.move();
  currentScene.render();
  
  if ( currentScene.returnFlag() == true ) {
    currentScene.finalize();
    currentScene = new GameScene();
    currentScene.initialize();
  }
}
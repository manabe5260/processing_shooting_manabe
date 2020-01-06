
/*
ShootingGameメイン関数
パブリック変数, setup(), draw()

素材
タイトル、ゲーム、エンディング背景: いらすとや, https://www.irasutoya.com/
アイコン: icooon-mono, https://icooon-mono.com/
BGM: 魔王魂, https://maoudamashii.jokersounds.com/
SE: 効果音ラボ, https://soundeffect-lab.info/
*/

public static Memory memory;
Scene currentScene;

void setup() {
  size(1200, 900, P3D);
  background(0);
  smooth();
  
  imageMode(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER);

  textFont(loadFont("font/AgencyFB-Reg-48.vlw"), 32);

  currentScene = new TitleScene();
  currentScene.initialize();
  
  memory = new Memory();
}

void draw() {
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
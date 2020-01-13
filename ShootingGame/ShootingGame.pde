
/*
ShootingGameメイン関数
 ライブラリ, パブリック変数, setup(), draw()
 
 素材
 背景: いらすとや, https://www.irasutoya.com/
 アイコン: icooon-mono, https://icooon-mono.com/
 BGM: 魔王魂, https://maoudamashii.jokersounds.com/
 SE: 効果音ラボ, https://soundeffect-lab.info/
 */
 
//ライブラリのインポート
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

public Minim minim = new Minim(this);
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
  
  //タグをもとにシーン遷移
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

void stop() {
  minim.stop();
  super.stop();
}

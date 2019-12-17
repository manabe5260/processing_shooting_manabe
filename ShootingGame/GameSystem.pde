
class GameSystem{
  public PlayerShip playerShip;
  
  GameSystem(){
    playerShip = new PlayerShip(5, 5, 10, 10, color(255, 0, 0));
  }
  
  public void move(){
    playerShip.move();
  }

  public void render(){
    playerShip.render();    
  }
  
  public void hitBullet(){
  
  }
  
  public void score(){
  
  }
  
  public void isGameOver(){
  
  }
}
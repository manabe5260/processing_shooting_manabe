 
/*
Memory
*/ 
 
class Memory{
  private int score = 0;
  private String status = "";
  
  public void writeMemory(int _score, String _status){
    score = _score;
    status = _status;
  }
  
  public int readScore(){
    return score;
  }
  
  public String readStatus(){
    return status;
  }
}
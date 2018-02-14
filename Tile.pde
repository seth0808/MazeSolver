public class Tile {
  public int heightWidth, posX, posY, r, g, b;
  boolean clicked;
  boolean start;
  boolean end;
  
  public Tile(int heightWidth, int posX, int posY) {
    this.heightWidth = heightWidth;
    this.posX = posX;
    this.posY = posY;
    r = g = b = 50;
    clicked = false;
  }
  
  public boolean equalTo(Tile tile){
    return tile.posX == this.posX && tile.posY == this.posY;
  }
  
  public void drawRect() {
    fill(r, g, b);
    rect(posX, posY, heightWidth, heightWidth);
  }
  
  public boolean clickEvent(float x, float y) {
    //This box was clicked
    if (x > posX && x <= posX + heightWidth) {
      if (y > posY && y <= posY + heightWidth) {
        clicked = true;
        g = 255;
        return true;
      }
    }
    return false;
  }
  
  public void pressedEvent(float x, float y, boolean start){
     if (x > posX && x <= posX + heightWidth) {
      if (y > posY && y <= posY + heightWidth) {
        if (start){
          this.start = true;
          g = 50;
          b = 255;
        } else if (!start){
          end = true;
          g = 50;
          r = 255;
      }
     }
   }
 }
 
 public boolean getStart() {
   return start;
 }
 
 public boolean getEnd() {
   return end;
 }
 
 public void inPath(){
   r = 255;
   g = 255;
   b = 255;
 }
 
 

}
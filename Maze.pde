public Tile[][] tiles;
int tileGridHeight, tileHeightWidth;
Graph graph;
String textValue;
int shortestLength;

void setup() {
  tileGridHeight = 50;
  tileHeightWidth = 10;
  //windowSize = tileGridHeight * tileHeightWidth
  //Add 50 to height for commands
  size(500, 550);
  graph = new Graph();
  shortestLength = 0;
  textValue = "s : start | e : end | d : doDijkstras | click : setMazePoint | c : custom maze";
  tiles = new Tile[tileGridHeight][tileGridHeight];
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      Tile t = new Tile(tileHeightWidth, i * tileHeightWidth, j * tileHeightWidth);
      tiles[i][j] = t;
    }
  }
  
}

void draw() {
  fill(240);
  rect(-1, -1, 501, 551);
  
  fill(0);
  text(textValue, 25, 530);
  
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      tiles[i][j].drawRect();
    }
  }
  
}

void keyPressed() {
  if (key == 'r'){
    setup();
  }
  else if(key == 'c'){
    customMaze();
  }
  else if (key == 'd'){
    Tile start = null;
    Tile end = null;
    textValue = "Processing...";
    for (int i = 0; i < tiles.length; i++){
      for (int j = 0; j < tiles[0].length; j++){
      if (tiles[i][j].getStart()){
        start = tiles[i][j];
     } else if (tiles[i][j].getEnd()){
       end = tiles[i][j];
     }
    }
    }
    ArrayList<Tile> tilesInPath = new ArrayList<Tile>();
    shortestLength = graph.doDijkstras(start, end, tilesInPath);
    processPath(tilesInPath);
  } else {
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      if (key == 's'){
        tiles[i][j].pressedEvent(mouseX, mouseY, true);
      } else if (key == 'e'){
        tiles[i][j].pressedEvent(mouseX, mouseY, false);
      }
    }
  }
  }
}

void mouseClicked() {
   handleClicked(mouseX, mouseY);
 }
 
 public void handleClicked(float x, float y) {
   for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      if(tiles[i][j].clickEvent(x, y)){
        graph.addVertex(tiles[i][j]);
        //Check left connection
        if(x > tileHeightWidth){
          for (int k = 0; k < tiles.length; k++){
            for (int l = 0; l < tiles[0].length; l++){
              if(tiles[k][l].posX == tiles[i][j].posX - tileHeightWidth){
                if(tiles[k][l].posY == tiles[i][j].posY){
                  if(tiles[k][l].clicked){
                    graph.addDirectedEdge(tiles[i][j], tiles[k][l], 1);
                    graph.addDirectedEdge(tiles[k][l], tiles[i][j], 1);
                  }
                }
              }
            }
          }
        }
        //Check Right connection
        if(x < (tileHeightWidth * tileGridHeight) - tileHeightWidth){
          for (int k = 0; k < tiles.length; k++){
            for (int l = 0; l < tiles[0].length; l++){
              if(tiles[k][l].posX == tiles[i][j].posX + tileHeightWidth){
                if(tiles[k][l].posY == tiles[i][j].posY){
                  if(tiles[k][l].clicked){
                    graph.addDirectedEdge(tiles[i][j], tiles[k][l], 1);
                    graph.addDirectedEdge(tiles[k][l], tiles[i][j], 1);
                  }
                }
              }
            }
          }
        }
        //Check Up connection
        if(y > tileHeightWidth){
          for (int k = 0; k < tiles.length; k++){
            for (int l = 0; l < tiles[0].length; l++){
              if(tiles[k][l].posX == tiles[i][j].posX){
                if(tiles[k][l].posY == tiles[i][j].posY - tileHeightWidth){
                  if(tiles[k][l].clicked){
                    graph.addDirectedEdge(tiles[i][j], tiles[k][l], 1);
                    graph.addDirectedEdge(tiles[k][l], tiles[i][j], 1);
                  }
                }
              }
            }
          }
        }
        //Check Down connection
        if(y < (tileHeightWidth * tileGridHeight) - tileHeightWidth){
          for (int k = 0; k < tiles.length; k++){
            for (int l = 0; l < tiles[0].length; l++){
              if(tiles[k][l].posX == tiles[i][j].posX){
                if(tiles[k][l].posY == tiles[i][j].posY + tileHeightWidth){
                  if(tiles[k][l].clicked){
                    graph.addDirectedEdge(tiles[i][j], tiles[k][l], 1);
                    graph.addDirectedEdge(tiles[k][l], tiles[i][j], 1);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
 }
 
 public void customMaze() {
   handleClicked(2.01 * tileHeightWidth, 2.01 * tileHeightWidth);
   handleClicked(3.01 * tileHeightWidth, 2.01 * tileHeightWidth);
   handleClicked(4.01 * tileHeightWidth, 2.01 * tileHeightWidth);
   handleClicked(5.01 * tileHeightWidth, 2.01 * tileHeightWidth);
   handleClicked(5.01 * tileHeightWidth, 3.01 * tileHeightWidth);
   handleClicked(5.01 * tileHeightWidth, 4.01 * tileHeightWidth);
   handleClicked(5.01 * tileHeightWidth, 5.01 * tileHeightWidth);
   handleClicked(4.01 * tileHeightWidth, 5.01 * tileHeightWidth);
   handleClicked(3.01 * tileHeightWidth, 5.01 * tileHeightWidth);
   handleClicked(2.01 * tileHeightWidth, 5.01 * tileHeightWidth);
   handleClicked(2.01 * tileHeightWidth, 4.01 * tileHeightWidth);
   handleClicked(2.01 * tileHeightWidth, 3.01 * tileHeightWidth);
 }
 
 public void processPath(ArrayList<Tile> tilePath){
   for (Tile t: tilePath) {
     t.inPath();

   }
   if (shortestLength != 0){
     shortestLength ++;
   }
   textValue = "Done, Shortest length is " + shortestLength + " steps.\n r: restart";
 }
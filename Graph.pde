public class Graph {
  private HashMap<Tile, HashMap<Tile, Integer>> adjacencyMap;
  private ArrayList<Tile> data;
  
  public Graph() {
    adjacencyMap = new HashMap<Tile, HashMap<Tile, Integer>>();
    data = new ArrayList<Tile>();
  }
  
  public void addVertex(Tile tile) {
    adjacencyMap.put(tile, new HashMap<Tile, Integer>());
    data.add(tile);
  }
  
  public void addDirectedEdge(Tile start, Tile end, int cost) {
    HashMap<Tile, Integer> adjacentVertices = adjacencyMap.get(start);
    adjacentVertices.put(end, cost);
    adjacencyMap.put(start, adjacentVertices);
    
  }
  
  public int doDijkstras(Tile startVertexName, Tile endVertexName, ArrayList<Tile> shortestPath){
    HashMap<Tile, Integer> currCost = new HashMap<Tile, Integer>();
    ArrayList<Tile> visited = new ArrayList<Tile>();
    HashMap<Tile, ArrayList<Tile>> currPath = new HashMap<Tile, ArrayList<Tile>>();
    
    for(Tile node: this.data) {
      if (node.equalTo(startVertexName)) {
        ArrayList<Tile> newPath = new ArrayList<Tile>();
        newPath.add(node);
        currPath.put(node, newPath);
      } else {
        ArrayList<Tile> newPath = new ArrayList<Tile>();
        currPath.put(node, newPath);
      }
    }
    
    
    for(Tile node: this.data) {
      if (node.equalTo(startVertexName)) {
        currCost.put(node, 0);
      } else {
        currCost.put(node, -1);
      }
    }
    boolean nodeLeft = true;
    while (nodeLeft) {
      
      //Find smallest node not in visited
      Tile node = null;
      int lowestCost = -1;
      for (Tile possibleNode: data) {
        if (lowestCost == -1) {
          if (!contains(visited, possibleNode)) {
            lowestCost = currCost.get(possibleNode);
            node = possibleNode;
          }
        } else {
          if (currCost.get(possibleNode) == -1) {
            
          
          } else if (currCost.get(possibleNode) < lowestCost && !contains(visited, possibleNode)) {
            lowestCost = currCost.get(possibleNode);
            node = possibleNode;
          }
        }
        
      }
      
      visited.add(node);
      
     
      
      
      
      for(Tile adjNode: adjacencyMap.get(node).keySet()) {
        if (!contains(visited, adjNode)) {
          if (currCost.get(adjNode) == -1 || currCost.get(adjNode) > currCost.get(node) + adjacencyMap.get(node).get(adjNode)) {
            if(currCost.get(node) != -1) {
              int newCost = currCost.get(node) + adjacencyMap.get(node).get(adjNode);
              currCost.put(adjNode, newCost);
              
              ArrayList<Tile> newPath = new ArrayList<Tile>();
              for(Tile pathNode: currPath.get(node)) {
                newPath.add(pathNode);
              }
              newPath.add(adjNode);
              currPath.put(adjNode, newPath);
            }
          }
        }
      }
      
      //Condition to check if there are nodes left. 
      int nodesLeft = 0;
      for (Tile possibleNode: data) {
        if (!contains(visited, possibleNode)) {
          nodesLeft ++;
        }
      }
      if (nodesLeft == 0) {
        nodeLeft = false;
      }
      
    }
    
    if(currCost.get(endVertexName) == -1) {
      ArrayList<Tile> newPath = new ArrayList<Tile>();
      currPath.put(endVertexName, newPath);
    }
    
    for(Tile pathNode: currPath.get(endVertexName)) {
      shortestPath.add(pathNode);
    }
    return currCost.get(endVertexName);
      
  }
  
  public boolean contains(ArrayList<Tile> list, Tile tile){
    boolean contains = false;
    for(Tile t: list){
      if(t.equalTo(tile)){
        contains = true;
      }
    }
    
    return contains;
      
  }
  
}
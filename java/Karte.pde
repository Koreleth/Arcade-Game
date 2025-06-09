/*
Karte class
  this class creates the map and checks if map changing. 
  Autor: Korel Öztekin
  date: 15.03.2024
*/


class Karte {

  //0 = hard wall
  //1 = no wall
  //2 = destroyable wall
  //3 = no wall -> item spawn random
  
  int [][] map = {
    {0,0,0,0,0,  0,0,0,0,0,  0,0,0,0,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,1,0,1,0,  2,0,2,0,2,  0,1,0,1,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,2,0,2,0,  2,0,2,0,2,  0,2,0,2,0},
    
    {0,2,2,2,2,  2,1,2,1,2,  2,2,2,2,0},
    {0,1,0,1,0,  1,0,2,0,1,  0,1,0,1,0},
    {0,2,2,2,2,  2,2,2,2,2,  2,2,2,2,0},
    {0,1,0,1,0,  1,0,2,0,1,  0,1,0,1,0},
    {0,2,2,2,2,  2,1,2,1,2,  2,2,2,2,0},
    
    {0,2,0,2,0,  2,0,2,0,2,  0,2,0,2,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,1,0,1,0,  2,0,2,0,2,  0,1,0,1,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,0,0,0,0,  0,0,0,0,0,  0,0,0,0,0}
};
  //SAVE: Map
  int [][] resetMap =  {
    {0,0,0,0,0,  0,0,0,0,0,  0,0,0,0,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,1,0,1,0,  2,0,2,0,2,  0,1,0,1,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,2,0,2,0,  2,0,2,0,2,  0,2,0,2,0},
    
    {0,2,2,2,2,  2,1,2,1,2,  2,2,2,2,0},
    {0,1,0,1,0,  1,0,2,0,1,  0,1,0,1,0},
    {0,2,2,2,2,  2,2,2,2,2,  2,2,2,2,0},
    {0,1,0,1,0,  1,0,2,0,1,  0,1,0,1,0},
    {0,2,2,2,2,  2,1,2,1,2,  2,2,2,2,0},
    
    {0,2,0,2,0,  2,0,2,0,2,  0,2,0,2,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,1,0,1,0,  2,0,2,0,2,  0,1,0,1,0},
    {0,1,1,1,2,  2,1,2,1,2,  2,1,1,1,0},
    {0,0,0,0,0,  0,0,0,0,0,  0,0,0,0,0}
};

 //0 = No Item
 //1 = BombInv Item
 //2 = Explosionradius Item
 //3 = Speed Item
 
 byte itemMap [][] = new byte [15][15];

  void render () {
    fill (255, 0, 0);
    
  // Draw map
  imageMode(CORNER);
  
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      if (map[i][j] == 0) {
        image (wall0, j * block, i * block, block, block);
      } else if (map[i][j] == 1) {
        image (wall1, j * block, i * block, block, block);
      } else if (map[i][j] == 2) {
        image (wall2, j * block, i * block, block, block);
      } else if (map [i][j] == 3) {
        image (wall1, j * block, i * block, block, block);
      }
      
    }
  }
  
    //DRAW: Items
    imageMode (CENTER);
    for (int i = 0; i < itemMap.length; i++) {
      for (int j = 0; j < itemMap[i].length; j++) {
        if (itemMap [i][j] != 0) {
          if (itemMap[i][j] == 1) {
            PImage itemCurrent = items.get(2* 17 ,0, 16,16);
            image (itemCurrent, j*block + (block/2), i*block + (block/2),30,30);
          } else if (itemMap[i][j] == 2) {
            PImage itemCurrent = items.get(1* 17 ,0, 16,16);
            image (itemCurrent, j*block + (block/2), i*block + (block/2),30,30);
          } else if (itemMap [i][j] == 3) {
            PImage itemCurrent = items.get(3* 17 ,0, 16,16);
            image (itemCurrent, j*block + (block/2), i*block + (block/2),30,30);
          }

        }
      }
    }
    imageMode (CORNER);
    fill (155, 155, 155);
  }


  //COLISION: Explsoion with Map
  void change (int [][]  explosionMap, boolean explosionActive, boolean bombActive) {
    for (int i = 0; i < explosionMap.length; i++) {
      for (int j = 0; j < explosionMap[i].length; j++) {
        if (explosionMap [i][j] == 3 && map[i][j] == 2) {
        
        if (explosionActive && bombActive) {
           map [i][j] = 1;
      
           int item = int (random (1,50));
       
       // 1: Bomb+ Item | 2: Radius+ Item | 3: Speed+ Item
       if (item >= 1 && item <= 8) {
         itemMap [i][j] = 1;
         } else if (item > 12 && item <= 20) {
           itemMap [i][j] = 2;
         } else if (item > 20 && item <= 23) {
           itemMap [i][j] = 3;
         }
        }               
      }
    }
  }
}
 
 
   void resetMap () {
      for (int i = 0; i < map.length; i++) {
        for (int j = 0; j < map[i].length; j++) {
          map[i][j] = resetMap [i][j];
          itemMap [i][j] = 0;
         }
      }    
   }
 
 
}

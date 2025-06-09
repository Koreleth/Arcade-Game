/*
Bomb class
  if keypressed, this class will be created. After explosion it will be dealeted
  Autor: Korel Öztekin
  date: 15.03.2024
*/


class Bomb {
  //ITEM Variable
  int bombMultipliyer;
  
  //import variables
  PVector playerPos;
  
  
  PVector bombPos = new PVector();
  boolean bombActive = true;
  boolean explosionActive = false;
  boolean explode = false;
  boolean destroyRight=true;
  int endExplodePos = 0;
  PVector[] bombs = new PVector [10];
  PVector explosionPos = new PVector();
  int [][] explosionMap = new int [15][15];
  
  int hitframe = frameCount;
  
  
  
  Bomb (PVector playerPos, int explosionRadius){
    this.playerPos = playerPos;
    
    //BOMB: Planting Center of player position
    bombPos.x = int (playerPos.x/block)*block+(block/2);
    bombPos.y = int (playerPos.y/block)*block+(block/2);
    this.bombMultipliyer = explosionRadius;
    
  }
  
  void bombPlanted (int [][] map) {
    imageMode(CENTER);
    
    //DRAW: Bomb
    if (bombActive) {
     PImage current = bombPic.get( (64/4) * ((frameCount/15)%4), 0, 64/4,16);
     image (current, bombPos.x, bombPos.y, 40, 40);
   
     
     //TIMER: Bomb -> Explode
     if ((frameCount-hitframe) % 150 == 0) {
       explosionActive = true;
       bombActive = false;
       hitframe = frameCount;
       explode = true;
       osc.send(explosionMessage, myAdress);
       
        } 
      imageMode (CORNER);
        
        
    //______________explosion_______________________

        
     } if (explosionActive) {
       imageMode(CENTER);
       
       //DRAW: explosioncenter
       PImage currentMidExplosion = explosionPic.get(96, 16 * ((frameCount/15)%4), 16, 16);
       image (currentMidExplosion, bombPos.x, bombPos.y, block, block);
       explosionMap [int (bombPos.y/block)][int (bombPos.x/block)] = 3;
      
       
       //DRAW: explosion in x+ direction
       for (int i = 1; i<=bombMultipliyer; i++) {
        //COLISION: if there is a hard wall
        if (map [int (bombPos.y/block)][int (((bombPos.x)+(block*i))/block)] == 0) {
        break; 
      }
      if (i == bombMultipliyer || map [int (bombPos.y/block)][int (((bombPos.x)+(block*i))/block)] == 2) {
         PImage currentREndExplosion = explosionPic.get(48, 16 * ((frameCount/15)%4), 16, 16);
         image (currentREndExplosion, bombPos.x+(block*i), bombPos.y, block, block);
       } else {
           PImage currentRExplosion = explosionPic.get(80, 16 * ((frameCount/15)%4), 16, 16);
           image (currentRExplosion, bombPos.x+(block*i), bombPos.y, block, block);
          } 
       //CREATE: int [][] variables
       explosionMap [int (bombPos.y/block)][int (((bombPos.x)+(block*i))/block)] = 3;        
       //COLLISION: if there is a destroyable wall
       if (map [int (bombPos.y/block)][int (((bombPos.x)+(block*(i)))/block)] == 2){
         break;
       }
     }
   
     
       //DRAW: explosion in x- direction
       for (int i = 1; i<=bombMultipliyer; i++) {
        //COLOSION: if there is a hard wall
        if (map [int (bombPos.y/block)][int (((bombPos.x)-(block*i))/block)] == 0) {
         break; 
       } if (i == bombMultipliyer || map [int (bombPos.y/block)][int (((bombPos.x)-(block*i))/block)] == 2) {
         PImage currentLEndExplosion = explosionPic.get(32, 16 * ((frameCount/15)%4), 16, 16);
         image (currentLEndExplosion, bombPos.x-(block*i), bombPos.y, block, block);
        } else {
          PImage currentLExplosion = explosionPic.get(80, 16 * ((frameCount/15)%4), 16, 16);
          image (currentLExplosion, bombPos.x-(block*i), bombPos.y, block, block);
        }      
         //CREATE: int [][] variables
         explosionMap [int (bombPos.y/block)][int (((bombPos.x)-(block*i))/block)] = 3;      
         //COLISION: if there is a destroyable wall
         if (map [int (bombPos.y/block)][int (((bombPos.x)-(block*(i)))/block)] == 2){
         break;
       }
     }
   
   
       //DRAW: explosion in y+ direction
       for (int i = 1; i<=bombMultipliyer; i++) {       
        //COLISION: if there is a destroyable wall
        if (map [int (((bombPos.y+(block*i)))/block)][int (bombPos.x/block)] == 0) {
         break; 
      } if (i == bombMultipliyer || map [int (((bombPos.y+(block*i)))/block)][int (bombPos.x/block)] == 2) {
          PImage currentREndExplosion = explosionPic.get(16, 16 * ((frameCount/15)%4), 16, 16);
          image (currentREndExplosion, bombPos.x, bombPos.y+(block*i), block, block);
        } else {
          PImage currentRExplosion = explosionPic.get(64, 16 * ((frameCount/15)%4), 16, 16);
          image (currentRExplosion, bombPos.x, bombPos.y+(block*i), block, block);
        } 
       //CREATE: int [][] variables
       explosionMap [int ((bombPos.y+(block*i))/block)][int (bombPos.x/block)] = 3;
       //COLISION: if there is a destoyable wall
       if (map [int ((bombPos.y+(block*(i)))/block)][int (bombPos.x/block)] == 2){
         break;
       }
     }
   
   
       // DRAW: explosion in y- direction
       for (int i = 1; i<=bombMultipliyer; i++) {      
       //COLISION: if there is a hard wall
        if (map [int (((bombPos.y-(block*i)))/block)][int (bombPos.x/block)] == 0) {
         break; 
      }  if (i == bombMultipliyer || map [int (((bombPos.y-(block*i)))/block)][int (bombPos.x/block)] == 2) {
         PImage currentREndExplosion = explosionPic.get(0, 16 * int((frameCount/15)%4), 16, 16);
         image (currentREndExplosion, bombPos.x, bombPos.y-(block*i), block, block);
      }  else {
         PImage currentRExplosion = explosionPic.get(64, 16 * int((frameCount/15)%4), 16, 16);
         image (currentRExplosion, bombPos.x, bombPos.y-(block*i), block, block);
      } 
      //CREATE: int [][] variables
       explosionMap [int ((bombPos.y-(block*i))/block)][int (bombPos.x/block)] = 3;      
      //COLISION: if there is a destroyable wall
       if (map [int ((bombPos.y-(block*(i)))/block)][int (bombPos.x/block)] == 2){
         break;
       }
     }
   
    //TIMER: Explosion -> Ending
     if ((frameCount-hitframe+1) % 60 == 0){
         explosionActive = false;
     }
   }
    
  }
  //_____________end Explosion_____________________
  
  
 
}

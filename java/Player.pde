/*
Player class
  creates player one and player two, creating variables, and checking collisions with #Karte
  Autor: Korel Öztekin
  date: 15.03.2024
*/


class Player {
  //ITEM variables
  int speed = 2;
  int invBomb = 1;
  int explosionRadius = 1;
  
  //player variables
  int live = 3;
  boolean hit = true;
  boolean cooldown = false;
  boolean respawntimer = true;
  
  //playerposition
  PVector pos = new PVector();
  PVector spawnPos = new PVector();
  //playersize
  int pWidth = 18;
  int pHeight = 24;
  float imageFactor = 2.3;
  int correcture = 12;
  int playerMapX = 0;
  int playerMapY = 0;
  //sides of Player    l == left  ;  r == right ;  u == up  ;  d == down  ;
  int mxl = 0; 
  int mxr = 0;
  int myu = 0;
  int myd = 0;
  
  
  int hitframe = 0;
  boolean[] keys = new boolean[4];
  boolean playerInBomb = false;
  int lastDirection = 0;
  
  
  //CONSTRUCTOR
  Player (int x, int y) {
    pos.x = x;
    pos.y = y;
    spawnPos.x = pos.x;
    spawnPos.y = pos.y;
    
    //POSTIION: each side of player
    mxl = (x-pWidth)/block;
    mxr = (x+pWidth)/block;
    myu = (y-20)/block;
    myd = (y+20)/block; 
  }

  void reset () {
    live = 3;
    speed = 2;
    invBomb = 1;
    explosionRadius = 1;
    lastDirection = 0;
    pos.x = spawnPos.x;
    pos.y = spawnPos.y;
    cooldown = false;
  }

 void render(PImage playerPic) {
   rectMode(CENTER);
    
    //ANIMATION: Hit by explosion
    if (cooldown) {
      imageMode (CENTER);
      image (blood, width/2, height/2);
      image (kill, width/2 + frameCount%5 ,height/2 + frameCount%10);
      PImage dieAnimation2 = playerPic.get (24 * ((frameCount/5)%6), 32*5, 24,32);
      image (dieAnimation2, pos.x, pos.y-correcture, imageFactor*pWidth, imageFactor * pHeight);
      imageMode (CORNER);
     }  
  }
 
 
 void move (int [][] map, PImage playerPic) {
    playerMapY = int (pos.y/block);
    playerMapX = int (pos.x/block);
    if (respawntimer && !cooldown ) {
      if ((frameCount/10)%2 == 0)
      tint(255, 128);
    } else {
      tint(255, 255);
  }
  
   //COLISION: with Bomb, destroyable wall, hard wall
   if (keys[0] || keys[1] || keys[2] || keys[3])  {
     
    //WALK: Up
    if (keys[0]) {
      if (map [int(((pos.y-speed)-(pHeight/2))/block)][int((pos.x+(pWidth/2))/block)] == 1 &&
        map [int(((pos.y-speed)-(pHeight/2))/block)][int((pos.x-(pWidth/2))/block)] == 1 ){
        pos.y -= speed;
        imageMode (CENTER);
        PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),64,24,32);
        image (currentPic, pos.x, pos.y - correcture,imageFactor * pWidth, imageFactor * pHeight);        
        lastDirection = 2;
      } else {
        imageMode (CENTER);
        PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),64,24,32);
        image (currentPic, pos.x, pos.y - correcture, imageFactor * pWidth, imageFactor * pHeight); 
        lastDirection = 2;
      }
    }
    
   //WALK: Down
   if (keys[1]) {
    if (map [int(((pos.y+speed)+(pHeight/2))/block)][int((pos.x+(pWidth/2))/block)] == 1  && 
      map [int(((pos.y+speed)+(pHeight/2))/block)][int((pos.x-(pWidth/2))/block)] == 1){
      pos.y += speed;
      imageMode (CENTER);
      PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),32,24,32);
      image (currentPic, pos.x, pos.y- correcture, imageFactor * pWidth, imageFactor * pHeight);     
      lastDirection = 1;
    } else {
      imageMode (CENTER);
      PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),32,24,32);
      image (currentPic, pos.x, pos.y- correcture, imageFactor * pWidth, imageFactor * pHeight);
      lastDirection = 1;
    }
  }
  
  //WALK: Left
  if (keys[2]) {
    if (map [int((pos.y-(pHeight/2))/block)][int(((pos.x-speed)-(pWidth/2))/block)] == 1  && 
      map [int((pos.y+(pHeight/2))/block)][int(((pos.x-speed)-(pWidth/2))/block)] == 1){
      pos.x -= speed;
      imageMode (CENTER);
      scale (-1,1);
      PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),0,24,32);
      image (currentPic, -pos.x, pos.y- correcture, imageFactor * pWidth, imageFactor * pHeight);
      scale (-1,1);
      lastDirection = 3;
    } else {
      imageMode (CENTER);
      scale (-1,1);
      PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),0,24,32);
      image (currentPic, -pos.x, pos.y- correcture, imageFactor * pWidth, imageFactor * pHeight);
      scale (-1,1);
      lastDirection = 3;
    }
  }
  
  //WALK: Right
  if (keys[3]) {
    if (map [int((pos.y-(pHeight/2))/block)][int(((pos.x+speed)+(pWidth/2))/block)] == 1  && 
      map [int((pos.y+(pHeight/2))/block)][int(((pos.x+speed)+(pWidth/2))/block)] == 1){
      pos.x += speed;
      imageMode (CENTER);
      PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),0,24,32);
      image (currentPic, pos.x, pos.y- correcture,imageFactor * pWidth, imageFactor * pHeight);
      lastDirection = 0;
    }     
      else {
      imageMode (CENTER);
      PImage currentPic = playerPic.get(24 + (24 * ((frameCount/10)%2)),0,24,32);
      image (currentPic, pos.x, pos.y- correcture,imageFactor * pWidth, imageFactor * pHeight);
      lastDirection = 0;  
    }
  }
  
 //ANIMATION: while not walkin
  } else if (!cooldown){
     if (lastDirection != 3) {
     imageMode (CENTER);
     PImage currentPic = playerPic.get(0,32 * lastDirection,24,32);
     image (currentPic, pos.x, pos.y- correcture, imageFactor * pWidth, imageFactor * pHeight);
     }
     else {
     imageMode (CENTER);
     scale (-1,1);
     PImage currentPic = playerPic.get(0,0,24,32);
     image (currentPic, -pos.x, pos.y- correcture, imageFactor * pWidth, imageFactor * pHeight);
     scale (-1,1);
     }
   }
   tint(255, 255);
 }
 
 
 void checkHit (int explosionMap [][], OscMessage hitMessage) {
   
   //COLISION: Player hit with bomb
   if (explosionMap [int ( (pos.y+pHeight-15)/block )] [playerMapX] == 3 || explosionMap [int ( (pos.y-pHeight+30)/block )] [playerMapX] == 3
    || explosionMap [playerMapY] [int ( (pos.x+pWidth-20)/block )] == 3  || explosionMap [playerMapY] [int ( (pos.x-pWidth+20)/block )] == 3)  {
    hit = true;
   
 //STAR: Cooldown
     if (hit && !respawntimer) {
       live = live -1;
       osc.send (hitMessage,myAdress);
       respawntimer = true;
       osc.send(sliceMessage, myAdress);
       osc.send(killMessage, myAdress);
       cooldown = true;
       // to mainclass
       hitframe = frameCount; 
     }
   }
 }
 
 
 void checkBomb (PVector bombPos, boolean bombActive) {
   
   //COLISION: Player with bomb
   if ( ( ((pos.x) > (bombPos.x - 40) && (pos.x) < (bombPos.x + 40) )  &&  ( (pos.y) > (bombPos.y - 40) && (pos.y) < (bombPos.y + 40) ) )   ) {    
   playerInBomb = true;
   
   } else {
   playerInBomb = false;   
   }
   if ( ( ((pos.x + speed) >= bombPos.x - 40 && !(pos.x >= bombPos.x + 40))  && (pos.y <= bombPos.y +40 && pos.y >= bombPos.y - 40) )  && !playerInBomb && bombActive ) {
     keys [3] = false;
   }
    if ( ( ((pos.x - speed) <= bombPos.x + 40 && !(pos.x <= bombPos.x - 40))  && (pos.y <= bombPos.y +40 && pos.y >= bombPos.y - 40) )  && !playerInBomb && bombActive ) {
     keys [2] = false; 
   }
    if ( ( ((pos.y + speed) >= bombPos.y - 40 && !(pos.y >= bombPos.y + 40))  && (pos.x <= bombPos.x +40 && pos.x >= bombPos.x - 40) )  && !playerInBomb && bombActive ) {
     keys [1] = false;
   }
    if ( ( ((pos.y - speed) <= bombPos.y + 40 && !(pos.y <= bombPos.y - 40))  && (pos.x <= bombPos.x +40 && pos.x >= bombPos.x - 40) )  && !playerInBomb && bombActive ) {
    keys [0] = false;
   }   
 }

  void itemCollected (byte [][] itemMap) {
    //COLISION: Player with Item
    if (itemMap [playerMapY] [playerMapX] == 1) {
      invBomb++;
      itemMap [playerMapY] [playerMapX] = 0;
      osc.send(itemMessage, myAdress);
    } else if (itemMap [playerMapY] [playerMapX] == 2) {
      explosionRadius++;
      itemMap [playerMapY] [playerMapX] = 0;
      osc.send(itemMessage, myAdress);
    } else if (itemMap [playerMapY] [playerMapX] == 3) {
      speed++;
      itemMap [playerMapY] [playerMapX] = 0;
      osc.send(itemMessage, myAdress);
    }
  }
  
  void respawn () {
    pos.x = spawnPos.x;
    pos.y = spawnPos.y;
  }
 


 
 //for movement 
 
 void keyPressed(int [] keyCodePlayer) {
  
   
    if (keyCodePlayer[0] == keyCode) {
    keys [0] = true;
    keys [2] = false;
    keys [3] = false;
    }
    if (keyCodePlayer[1] == keyCode) {
    keys [1] = true;
    keys [2] = false;
    keys [3] = false;
    }
    if (keyCodePlayer[2] == keyCode) {
    keys [2] = true;
    keys [0] = false;
    keys [1] = false;
    }
    if (keyCodePlayer[3] == keyCode) {
    keys [3] = true;
    keys [0] = false;
    keys [1] = false;
    }
    
    
}
    
void keyReleased(int [] keyCodePlayer) {
   if (keyCodePlayer[0] == keyCode) {
    keys [0] = false;
    }
    if (keyCodePlayer[1] == keyCode) {
    keys [1] = false;
    }
    if (keyCodePlayer[2] == keyCode) {
    keys [2] = false;
    }
    if (keyCodePlayer[3] == keyCode) {
    keys [3] = false;
    }
    
}

  
}

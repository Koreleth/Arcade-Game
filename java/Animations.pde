/*
Bomb class
  if keypressed, this class will be created. After explosion it will be dealeted
  Autor: Korel Öztekin
  date: 15.03.2024
*/


class Animations {
 
  void playButton () {
    if (mouseX < 370 && mouseX > 30 && mouseY < 560 && mouseY > 480) {
      hover ();
      cursor (HAND);
    if (mousePressed) {
      //gamestart sound
      osc.send(stopMessage, myAdress);
      osc.send(clickMessage, myAdress);
      osc.send(counterMessage, myAdress);
      gamemode = 2;
    }
    } else if (!(mouseX < 70 && mouseX > 10 && mouseY < 70 && mouseY > 10) && 
      !(mouseX < 740 && mouseX > 680 && mouseY < 60 && mouseY > 10)) {
       resetHover();
    }  
  }
  
  
  void hover () {
    addsize = 1.02;
    colorR = 235;
    colorG = 140;
    colorB = 70;
    cursor (HAND);
    
  }
  
  //RESET: Cursor and color
  void resetHover () {
    addsize = 1;
    colorR = 255;
    colorG = 255;
    colorB = 255;
    cursor (ARROW);
  }
  
  void variable () {
  //ANIMATION: Counter for menu character
    if (frameCount%2 == 0) {
      switch (animation) {
      case 0:
      movement.x++;   
      if (movement.x > 60) {
        animation = 1;
        }
        break;
       case 1:
       movement.x --;
       if (movement.x < 0) {
         animation = 0;
       }
       break;
      }    
    }
  }
 
 void beforeGame() {
   
   //COUNTER: int ++ and int--
   if (animationCounter >= 350 && animationCounter < 395) {
       animationCounter++;
     }else {
       animationCounter = animationCounter + 50;
     }
     if (animationCounter > 750) {
       animationCounter = 0;
     }
     
     textSize(100);
     
     //TIMER: 0 -> DRAW: "Fight"
     if (((frameCount-hitFrameMain)/60)%4 == 3){
       fill (82,115,181);
       rect (width/2,height/2,750,100);
       PImage current = bomberman.get (0,200,750,100);
       image (current, 300, 325);
       fill(255);
       text ("FIGHT", width/2, 410);
       
     //TIMER: 3-1 -> DRAW: "number"
     } else if (3-((frameCount-hitFrameMain)/60) >= 0){    
       fill (82,115,181);
       rect (width/2,height/2,750,100);
       PImage current = bomberman.get (0,200,750,100);
       image (current, 300, 325);
       fill(255);
       text (3-((frameCount-hitFrameMain)/60), animationCounter, 410);
     }
     
    //RESET: hitframe for cooldown
    if (((frameCount-hitFrameMain)/60)%5 == 4){
      playerOne.hitframe = frameCount;
      playerTwo.hitframe = frameCount;
      startTimer = true;
      osc.send(ambientMessage, myAdress);
    }
     
 }
  
  void coolDownTimer () {
     //cooldown Timer
   if (playerOne.cooldown && (frameCount-playerOne.hitframe)%120==0) {
     playerOne.respawn ();
     osc.send(spawnMessage, myAdress);
     playerOne.cooldown = false;
   }
   if (playerTwo.cooldown && (frameCount-playerTwo.hitframe)%120==0) {
     playerTwo.respawn ();
     osc.send(spawnMessage, myAdress);
     playerTwo.cooldown = false;
   }
   if (playerOne.respawntimer && (frameCount-playerOne.hitframe)%300==0) {
     playerOne.respawntimer = false;
     
   }
   if (playerTwo.respawntimer && (frameCount-playerTwo.hitframe)%240==0) {
     playerTwo.respawntimer = false;
   }
   //cooldown Timer end
    
  }
  
  
  void endAnimation () {
    
    PImage current = banner.get (0,0,50*(frameCount-hitFrameMain),750);
    image (current, 0, 0);
    
     //Show WinnerTIE
  if ( (playerOne.live == 0 && !playerOne.cooldown) && (playerTwo.live == 0 && !playerTwo.cooldown)) {
    textFont (geospeed);
    textSize (128);
    fill (255);
    text ("TIE", animationCounter, height/2+40);
    
  } else {
    //SHOW Winner P2
    if (playerOne.live == 0) {
   
    textFont (geospeed);
    textSize (48);
    fill (255);
    text ("PLAYER TWO", animationCounter-130, (height/2)+20);
    text ("WINS", animationCounter-130, (height/2)+60);
    image (bomberman2, animationCounter-80,0);
    
    osc.send(p2winMessage, myAdress);
    
    //SHOW WIinner P1
    } else if (playerTwo.live == 0) {
    textFont (geospeed);
    textSize (48);
    fill (255);
    text ("PLAYER ONE", animationCounter+150, (height/2));
    text ("WINS", animationCounter+150, (height/2)+40);
    scale (-1,1);
    println (animationCounter);
    image (bomberman, -1* animationCounter-200,0);
    scale (-1,1);
    
    osc.send(p1winMessage, myAdress);
    }
    
  }
  //ANIMATION draw
  if (animationCounter >=350) {
     textSize (40);
     fill (255, 150+ ((5*frameCount)%205));
     text ("PRESS ANY KEY", width/2, 700);
   }
    
  }
  
  
  
  
}

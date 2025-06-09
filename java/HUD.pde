/*
HUD class
  this class prints points, live and other variables you can see
  Autor: Korel Öztekin
  date: 15.03.2024
*/

class HUD {
   
 void render (int liveP1, int speedP1, int bombsP1, int liveP2, int speedP2, int bombsP2, int radiusP1, int radiusP2) {
 imageMode (CENTER);
 
 
  //DRAW: Live P1
 if (liveP1 == 3) {
  
  image (heart, 70, 25, 25, 25);
  image (heart, 100, 25, 25, 25);
  image (heart, 130, 25, 25, 25);
 }
 else if (liveP1 == 2) {
  image (heart, 70, 25, 25, 25);
  image (heart, 100, 25, 25, 25);
  image (heart0, 130, 25, 25, 25);
 }
 else if (liveP1 == 1) {
  image (heart, 70, 25, 25, 25);
  image (heart0, 100, 25, 25, 25);
  image (heart0, 130, 25, 25, 25);
 }
 
 //DRAW: Speed P1
   fill (100,100,255);
   rect (205,25,50,20);
   image (skater, 180,25,100,100);  
   fill (255);
   text (" x " + (speedP1-1), 210,32);
  
  //DRAW: Bombinv P1
   fill (100,100,100);
   rect (295,25,50,20);
   PImage bombHud = bombPic.get(32,0,16,16);
   image (bombHud, 270,27,25,25);
   fill (255);
   text (" x " + bombsP1, 298,32);
   
   //DRAW: Explosionradius P1
   fill (200,100,0);
   rect (390,25,50,20);
   image (fire, 365,25,100,100);
   fill (255);
   text (" x " + radiusP1, 395,32);
   
   //DRAW: Image in corner
   PImage profileP1 = playerPic1.get(2,36,20,20);
   image (profileP1, 25, 25, 50,50);
     
   
  //DRAW: Live P2
   if (liveP2 == 3) {
    imageMode (CENTER);
    image (heart, 680, 725, 25, 25);
    image (heart, 650, 725, 25, 25);
    image (heart, 620, 725, 25, 25);
   }
   else if (liveP2 == 2) {
    image (heart, 680, 725, 25, 25);
    image (heart, 650, 725, 25, 25);
    image (heart0, 620, 725, 25, 25);
   }
   else if (liveP2 == 1) {
    image (heart, 680, 725, 25, 25);
    image (heart0, 650, 725, 25, 25);
    image (heart0, 620, 725, 25, 25);
   }
   
   //DRAW: Speed P2
     fill (100,100,255);
     rect (555,725,50,20);
     image (skater, 580,725,100,100);
     fill (255);
     text (speedP2-1 + " x ", 550,732);
  
    //DRAW: BombInv P2
     fill (100,100,100);
     rect (460,725,50,20);
     image (bombHud, 490,727,25,25);
     fill (255);
     text (bombsP2 + " x ", 453,732);
     
    //DRAW: Explosioradius P2
     fill (200,100,0);
     rect (370,725,50,20); 
     image (fire, 395,725,100,100);
     fill (255);
     text (radiusP2 + " x ", 365,732);
 
     //DRAW: Image corner
     PImage profileP2 = playerPic2.get(2,36,20,20);
     image (profileP2, 725, 725, 50,50);
     
     
     //DRAW: Enviroment
     //birds
     image (bird.get(20*((frameCount/10)%4),0,20,16),800 - (frameCount % 800),590, 40,32);
     image (bird.get(20*((frameCount/10)%4),0,20,16),800 - ((frameCount-170) % 800),7400, 40,32);
     image (bird.get(20*((frameCount/10)%4),0,20,16),800 - (((frameCount/3)-200) % 800),45);
     scale (-1,1);
     image (bird.get(20*((frameCount/10)%4),0,20,16),-((frameCount-70) % 800),320, 40,32);
     image (bird.get(20*((frameCount/10)%4),0,20,16),-(((frameCount-70)/2) % 800),75, 30,24);
     image (bird.get(20*((frameCount/10)%4),0,20,16),-(100 + (frameCount/3) % 800),630);
     scale (-1.1);
     
     imageMode (CORNER);     
   }
 
 
   void settingButton () {
     
     //ANIMATION: Hover over button
      if (mouseX < 70 && mouseX > 10 && mouseY < 70 && mouseY > 10) {
      cursor (HAND);
      if (mousePressed) {
        osc.send(clickMessage, myAdress);
        //game start
        gamemode = 1;
      }
    } 
   }
 
   void quitButton () {
     //ANIMATION: Hover over button
     if (mouseX < 740 && mouseX > 680 && mouseY < 60 && mouseY > 10) {
      cursor (HAND);
      if (mousePressed) {
        osc.send(stopAllMessage, myAdress);
        exit ();
      }
    }
   }
 
  void drawButtons () {
    //DRAW: Buttons
    image (close,width-30, 30, 40,40);
    image (menubox, 200, 500, 340*addsize, 175*addsize);
    fill(colorR, colorG, colorB);
    textFont (geospeed);
    textSize (50*addsize);
    text ("PLAY", 230,540);
    textFont (pixel);
    textSize (20);
    fill (255);
    text ("1.0.0", 70,730);
    text ("Bomberman", 70,710);
  }
  
  void drawMenu () {
    //DRAW: Menubackground
    fill (82,115,181);
    rect (width/2,height/2, width, height);
    image (logo, 240, 120, 500,500);
    image (bomberman, width-100 + movement.x, height/2 + movement.y);
    image (setting, 40,40, 80,80);
    hitFrameMain = frameCount;
  }
  
  void drawSetting () {
    //DRAW: Settingbackground
    fill (82,115,181);
    image (settingPage, width/2, height/2); 
    fill (255);
  }
  
  void drawTutorial () {
    //DRAW: Tutorial at beginning of game
    image (tutorial,0,0);
    bombkeyDraw(275,235,470,695, geospeed);      
  }

  void volumeDraw () {
    //DRAW: Volumebar
    rectMode (CORNER);
    noStroke ();
    text ("GAIN", width/2,40);
    fill (255, 70);
    rect (275, 55, 200,10);
    fill (255,255);
    rect (275, 55, 50*soundFactor,10);
    rectMode (CENTER);
    // "-" sign
    rect (250, 60, 10,5);
    // "+" sign
    rect (500, 60, 10,5);
    rect (500, 60, 5,10);
  }
  
  void bombkeyDraw (int xkey1, int ykey1, int xkey2, int ykey2, PFont thisFont) {
      //DRAW: Bombkey
      fill (255);
      textFont (thisFont);
      textSize (32);
      if (keyBombOne == 32) {
        text ("SPACE",xkey1,ykey1);
      } else {
      text (Character.toString(keyBombOne),xkey1,ykey1);
        }
      if (keyBombTwo == 18) {
        text ("ALT GR",xkey2,ykey2);
      } else {
      text (Character.toString(keyBombTwo),xkey2,ykey2);
      }      
    }
  
  void functionButtons () {
    //USE: Button back
    if (mouseX < 100 && mouseX > 10 && mouseY < 740 && mouseY > 680) {
      cursor (HAND);
      cursorHand = true;
      if (mousePressed) {
        osc.send(clickMessage, myAdress);
        gamemode = 0;
      } 
    //CURSORDESIGN: Back to arrow
    }else if (!(mouseX < 300 && mouseX > 50 && mouseY < 580 && mouseY >500) && !(mouseX < 670 && mouseX > 430 && mouseY < 580 && mouseY >500) 
    && !(mouseX < 510 && mouseX > 490 && mouseY < 70 && mouseY > 50) && !(mouseX < 260 && mouseX > 240 && mouseY < 70 && mouseY >50)) {
        cursor (ARROW);
        cursorHand = false;
      }
    
    //USE: Change bombkey P1
    if (mouseX < 300 && mouseX > 50 && mouseY < 580 && mouseY >500 && !keyChangeTwo) {
      cursor (HAND);
      cursorHand = true;
      if (mousePressed) {
        keyChangeOne = true;
        osc.send(clickMessage, myAdress);
      }
    } 
    if (keyChangeOne) {
      textSize (18);
      text ("changing KEYBIND of player two", width/2, 690);
      text ("Press KEY", width/2, 720);
      if (keyPressed) {
      keyBombOne = key;
      
      if (keyBombOne >= 97 && keyBombOne <=122) {
        keyBombOne -= 32;
      }
        keyChangeOne = false;
      }
    }
    //USE: Change bombkey P2
      if (mouseX < 670 && mouseX > 430 && mouseY < 580 && mouseY >500 && !keyChangeOne) {
         cursor (HAND);
         cursorHand = true;
      if (mousePressed) {  
        osc.send(clickMessage, myAdress);
        keyChangeTwo = true;
      }
    } 
    if (keyChangeTwo) {
      textSize (18);
      text ("changing KEYBIND of player two", width/2, 690);
      text ("Press KEY", width/2, 720);
      if (keyPressed) {
      keyBombTwo = key;
      if (keyBombTwo >= 97 && keyBombTwo <=122) {
       keyBombTwo -= 32;
      }
        keyChangeTwo = false;
      }
    }
    
    //USE: sound volume -
    if (mouseX < 260 && mouseX > 240 && mouseY < 70 && mouseY >50) {
         cursor (HAND);
       if (soundChange && soundFactor > 0 && mousePressed) {  
        soundFactor -= 1;
        if (soundFactor == 1) {
           osc.send(gain25Message, myAdress);
        } else if (soundFactor == 2) {
           osc.send(gain50Message, myAdress);
        } else if (soundFactor == 3) {
           osc.send(gain75Message, myAdress);
        } else if (soundFactor == 0) {
           osc.send(gain0Message, myAdress);
        }
        osc.send(clickMessage, myAdress);
        soundChange = false;
      }
    } 
    //USE: sound volume +
     if (mouseX < 510 && mouseX > 490 && mouseY < 70 && mouseY > 50) {
         cursor (HAND);
      if (soundChange && soundFactor < 4 && mousePressed) {  
        soundFactor += 1;
        if (soundFactor == 1) {
           osc.send(gain25Message, myAdress);
        } else if (soundFactor == 2) {
           osc.send(gain50Message, myAdress);
        } else if (soundFactor == 3) {
           osc.send(gain75Message, myAdress);
        } else if (soundFactor == 4) {
           osc.send(gain100Message, myAdress);
        }
        osc.send(clickMessage, myAdress);
        soundChange = false;
      }
    } 
  }
  
}

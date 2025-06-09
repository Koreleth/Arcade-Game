/*
Bomberman: 
  Autor: Korel Öztekin
  date: 15.03.2024
  version: 1.0.0
*/

//LIB: UDPReceive, OSCP5 & DOWNLOAD: MAX8 for sound
import oscP5.*;
import netP5.*;

OscP5 osc = new OscP5(this, 12345);
NetAddress myAdress = new NetAddress("127.0.0.1", 12345);

OscMessage stopMessage = new OscMessage("stop");
OscMessage hubMessage = new OscMessage("hub");
OscMessage bombMessage = new OscMessage("plopp");
OscMessage spawnMessage = new OscMessage("spawn");
OscMessage itemMessage = new OscMessage("item");
OscMessage hit1Message = new OscMessage("hit1");
OscMessage hit2Message = new OscMessage("hit2");
OscMessage clickMessage = new OscMessage("click");
OscMessage startMessage = new OscMessage("bomberman");
OscMessage counterMessage = new OscMessage("counter");
OscMessage ambientMessage = new OscMessage("ambient");
OscMessage explosionMessage = new OscMessage("explosion");
OscMessage p1winMessage = new OscMessage("p1");
OscMessage p2winMessage = new OscMessage("p2");
OscMessage sliceMessage = new OscMessage("slice");
OscMessage killMessage = new OscMessage("kill");
OscMessage stopAllMessage = new OscMessage("stopall");

OscMessage gain0Message = new OscMessage("mute");
OscMessage gain25Message = new OscMessage("sound25");
OscMessage gain50Message = new OscMessage("sound50");
OscMessage gain75Message = new OscMessage("sound75");
OscMessage gain100Message = new OscMessage("sound100");

//setup
int block = 50;
int gamemode = 0;
PFont pixel;
PImage heart;
PImage heart0;
PImage wall0;
PImage wall1;
PImage wall2;
PImage bombPic;
PImage items;
PImage explosionPic;
PImage explosionSide;
PImage playerPic1;
PImage playerPic2;
PImage skater0;
PImage skater;
PImage fire;
PImage banner;
PImage logo;
PImage setting;
PImage settingPage;
PImage close;
PImage kill;
PImage blood;
PImage bird;
PImage tutorial;

//player variables
int [] keyCodeOne = {87,83,65,68}; //playerOne -> w,s,a,d and SPACE
int [] keyCodeTwo = {UP,DOWN,LEFT,RIGHT}; //playerTwo -> Arrowkeys and ALTGR
Player playerOne = new Player (block+(block/2),block+(block/2)); //new Player (x,y);
Player playerTwo = new Player (700-(25),700-25);
int keyBombOne = 32;
int keyBombTwo = 18;

//map
Karte karte = new Karte ();

//HUD
HUD hud = new HUD ();

//animation
Animations ani = new Animations ();

//game
boolean startTimer;
int hitFrameMain;
int animationCounter;

//bomb
ArrayList <Bomb> bombP1 = new ArrayList<Bomb>();
ArrayList <Bomb> bombP2 = new ArrayList<Bomb>();
boolean bombKeyP1 = false;
boolean bombKeyP2 = false;
int explosionCountP1 = 0;
int explosionCountP2 = 0;


//MENU
PImage bomberman;
PImage bomberman2;
PImage menubox;
PVector movement = new PVector (0,0);
int animation = 0;
float addsize = 1;
PFont geospeed;
int colorR = 255;
int colorG = 255;
int colorB = 255;
int soundFactor = 2;
boolean keyChangeOne = false;
boolean keyChangeTwo = false;
boolean cursorHand = false;
boolean soundChange = false;


void setup () {
  size (750,750);
  frameRate (60);

  block = width/15;
  
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode (CENTER);
  textSize(20);
  
  heart = loadImage ("../sprites/heart.png");
  heart0 = loadImage ("../sprites/heart0.png");
  wall0 = loadImage ("../sprites/wall0.png");
  wall1 = loadImage ("../sprites/wall1.png");
  wall2 = loadImage ("../sprites/wall2.png");
  bombPic = loadImage ("../sprites/bombs.png");
  items = loadImage ("../sprites/items.png");
  explosionPic = loadImage ("../sprites/explosion.png");
  explosionSide = loadImage ("../sprites/explosionSide.png");
  playerPic1 = loadImage ("../sprites/player1.png");
  playerPic2 = loadImage ("../sprites/player2.png");
  skater0 = loadImage ("../sprites/skater0.png");
  skater = loadImage ("../sprites/skater.png");
  banner = loadImage ("../sprites/banner.png");
  fire = loadImage ("../sprites/fire.png");
  bomberman = loadImage ("../sprites/bomberman.png");
  logo = loadImage ("../sprites/logo.png");
  menubox = loadImage ("../sprites/Menu.png");
  bomberman2 = loadImage ("../sprites/bomberman2.png");
  setting = loadImage ("../sprites/setting.png");
  close = loadImage ("../sprites/close.png");
  kill = loadImage ("../sprites/kill.png");
  blood = loadImage ("../sprites/Blood.png");
  bird = loadImage ("../sprites/bird.png");
  tutorial = loadImage ("../sprites/tutorial.png");
  
  settingPage = loadImage ("../sprites/settingpage.png");
  geospeed = createFont("../font/geospeed.ttf",128);
  pixel = createFont("../font/pixel.ttf",128);
  
  osc.send(hubMessage, myAdress);
  osc.send(gain50Message, myAdress);
}



void draw () {
  switch (gamemode) {
    case 0:
    menuRender();
    break;
    
    case 1:
    setting ();
    break;
    
    case 2:
    gamestart ();
    break;
    
    case 3:
    endScreen ();
    break;
  }  
}



//case 0:
void menuRender() {
  imageMode (CENTER);
  //DRAW Menu
  hud.drawMenu ();
  
  //animationcounter
  ani.variable ();
  
  // BUTTON: Play
  ani.playButton();
  
   // BUTTON: Settings
  hud.settingButton();

  // BUTTON: Quit  
  hud.quitButton();
  
  //DRAW: Buttons
  hud.drawButtons();
  
 }
//__________________________________________________________________________________________
// __________________________________________________________________________________________


//case 1:
void setting () {
  imageMode (CENTER);
  //DRAW: Setting background
  hud.drawSetting();
  
  //USE: Button
  hud.functionButtons();

  //DRAW: Volume
  hud.volumeDraw();
  
  //DRAW: Bombkey (xPos of KEYCODE P1, yPos of KEYCODE P1, xPos of KEYCODE P2, yPos of KEYCODE P2, FONT);
  hud.bombkeyDraw(185,545,555,545, pixel);
  
}

//___________________________________________________________________
//___________________________________________________________________



//case 2:
void gamestart () {
   //gamemode  
   cursor (ARROW);
   textFont (pixel);
   textSize (18);
   karte.render ();
   
   //TIMER: 3,2,1,.. Counter + ANIMATION: Numbers
   if (!startTimer) {
     ani.beforeGame();
     hud.drawTutorial ();   
   }
   
   
   else {
   //TIMER: cooldown
   ani.coolDownTimer ();  
   
   //DRAW: BombList
   bombPlant();
   
   playerOne.itemCollected(karte.itemMap);
   playerTwo.itemCollected(karte.itemMap);
   
   playerOne.render (playerPic1);
   playerTwo.render (playerPic2);
   
   if (!playerOne.cooldown) {
   playerOne.move (karte.map, playerPic1);
   }
   if (!playerTwo.cooldown) {
   playerTwo.move (karte.map, playerPic2);
   } 
      
   //CHANGE: state if player 0 live
   if ( (playerOne.live == 0 && !playerOne.cooldown)  || (playerTwo.live == 0 && !playerTwo.cooldown) ) {
     hitFrameMain = frameCount;
     animationCounter = 0;
     gamemode = 3;
   }
   
   //DRAW: live, speed, bombcount, explosionradius, killtext
   hud.render(playerOne.live, playerOne.speed, playerOne.invBomb, playerTwo.live, playerTwo.speed, playerTwo.invBomb, playerOne.explosionRadius, playerTwo.explosionRadius);
  
   }
}

void bombPlant () {
  
   //COLISION: Explosion with player & Bomb with player
   for (int i = 0; i<bombP1.size(); i++){
     bombP1.get(i).bombPlanted(karte.map);
     playerOne.checkHit(bombP1.get(i).explosionMap, hit1Message);  
     playerTwo.checkHit(bombP1.get(i).explosionMap, hit2Message);
     playerOne.checkBomb(bombP1.get(i).bombPos, bombP1.get(i).bombActive);
     playerTwo.checkBomb(bombP1.get(i).bombPos, bombP1.get(i).bombActive);
     
     //COLISION: Explosion with map
     karte.change(bombP1.get(i).explosionMap, !bombP1.get(i).explosionActive, !bombP1.get(i).bombActive);
     
     //COUNTER: How many explosions
     if (bombP1.get(i).explode) {
       explosionCountP1++;
       bombP1.get(i).explode = false;
     }
     //REMOVE: delete bomb after explosion
     if (!bombP1.get(i).bombActive && !bombP1.get(i).explosionActive) {       
       bombP1.remove(i);
       explosionCountP1--;             
     }   
   }
   
   //REPEAT: for player two
   for (int i = 0; i<bombP2.size(); i++){
       bombP2.get(i).bombPlanted(karte.map);
       playerOne.checkHit(bombP2.get(i).explosionMap, hit1Message);  
       playerTwo.checkHit(bombP2.get(i).explosionMap, hit2Message);
       playerOne.checkBomb(bombP2.get(i).bombPos, bombP2.get(i).bombActive);
       playerTwo.checkBomb(bombP2.get(i).bombPos, bombP2.get(i).bombActive);
       
       //animation and change map after Explosion
       karte.change(bombP2.get(i).explosionMap, !bombP2.get(i).explosionActive, !bombP2.get(i).bombActive); 
       
       if (bombP2.get(i).explode) {
       explosionCountP2++;   
       bombP2.get(i).explode = false;
     }
       if (!bombP2.get(i).bombActive && !bombP2.get(i).explosionActive) {
         //delete Bomb
         bombP2.remove(i);
         explosionCountP2--;
     }
   }
  
  
}
//___________________________________________________________________________________________________
//___________________________________________________________________________________________________

//case 3:
void endScreen () {
  karte.render();
  
  //ANIMATION: Counter
   if (animationCounter >= 300 && animationCounter < 350) {
       animationCounter++;
     }else if (animationCounter < 300){
       animationCounter = animationCounter + 25;
  
  //BUTTON: Back to menu
     } else if (keyPressed) {
       playerOne.reset ();
       playerTwo.reset (); 
       explosionCountP1 = 0;
       explosionCountP2 = 0;
       startTimer = false;
       animationCounter = 0;
       karte.resetMap();
       
      for (int i = 0; i<bombP1.size(); i++){
         bombP1.remove(i);
       }
       for (int i = 0; i<bombP2.size(); i++){
         bombP2.remove(i);
       }
       
       osc.send(stopMessage, myAdress);
       osc.send(hubMessage, myAdress);
       gamemode = 0;
       
     }
     
     //DRAW Background banner
     ani.endAnimation();
     
  
}

//___________________________________________________________________________________________________
//___________________________________________________________________________________________________



void keyPressed () {
  //walk P1
  if (!playerOne.cooldown && gamemode == 2) {
  playerOne.keyPressed(keyCodeOne);
  }
  //walk P2
  if (!playerTwo.cooldown && gamemode ==2) {
  playerTwo.keyPressed(keyCodeTwo);
  }

//bombkey P1
    if (keyBombOne == keyCode && !playerOne.cooldown && gamemode == 2) {
      if (playerOne.invBomb > bombP1.size()-explosionCountP1){
        //create new Bomb
      bombP1.add(new Bomb(playerOne.pos, playerOne.explosionRadius));
      osc.send(bombMessage, myAdress);
      }
     }
     
//bombKey p2
   if (keyBombTwo == keyCode && !playerTwo.cooldown && gamemode == 2) {
      if (playerTwo.invBomb > bombP2.size()-explosionCountP2){
        //create new Bomb
      bombP2.add(new Bomb(playerTwo.pos, playerTwo.explosionRadius));
      osc.send(bombMessage, myAdress);
      }
     } 
     
} 

void keyReleased () {
 playerOne.keyReleased(keyCodeOne);
 playerTwo.keyReleased(keyCodeTwo);
}

void mouseReleased () {
  soundChange = true;
}

import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;
import peasy.*;



Satelite sat1;
Satelite sat2;
PeasyCam cam;

PShape globe;
PShape space;
PImage earth;
PImage Space;
float scale;
String sat_input;
String[] satIDArr;
Satelite[] satArr;

void setup () {
  
  sat_input = new UiBooster().showTextInputDialog("Enter Satellite ID, remember to separate them with a -");
  satIDArr = sat_input.split(",");
  printArray(satIDArr);
  println(satIDArr.length);
  
  
  scale = 0.01*width/1920; // skalaen, afhænger af skærmstørrelse
  

  satArr = new Satelite[satIDArr.length]; // laver en ny satelit for hvert ID.
  for (int i = 0; i < satIDArr.length; i++) {
    satArr[i] = new Satelite(satIDArr[i], scale);
  }


  //Setup for can and progress bar
  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);
  dialog.setProgress(10);
  dialog.setMessage("Loading cam");
  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(300);
  cam.setMaximumDistance(3000);
  fullScreen (P3D);

  //Loading images
  dialog.setProgress(40);
  dialog.setMessage("Loading Images");
  Space = loadImage ("data/Space.jpg");
  earth = loadImage("data/earth.jpg" );
  dialog.setProgress(70);
  dialog.setMessage("Loading shapes");

  //setup for globe
  globe = createShape (SPHERE, 6371*scale);
  globe.setTexture (earth);
  globe.setStroke (false);

  //Setup for space
  space = createShape (SPHERE, 4000);
  space.setTexture (Space);
  space.setStroke (false);

  //Setup for satelite
  dialog.setProgress(90);



  //Progress bar done
  dialog.setProgress(100);
  dialog.setMessage("Ready");
  delay(1000);
  dialog.close();
}

void draw() {
  //draws globe and the space around
  pushMatrix();
  translate(0, 0, 0);
  shape (globe);
  shape (space);
  popMatrix();

  //draws the satelites and the trajectory
  for (Satelite sat : satArr) {
    sat.drawSat();
  }

  //draws the GUI with the information about the satelites
  cam.beginHUD();
  fill(64, 64, 64);
  stroke (128, 128, 128);
  rect (15, 12, 350, (43*satArr.length), 20);
  noStroke();
  textSize(40);
  for ( int i = 0; i < satArr.length; i++) {
    fill(satArr[i].satColor);
    rect (30,(27+40*i) , 20, 20); //27*(i+1)
    fill (255, 255, 255);
    text (satArr[i].satName, 60, 50+40*i);
  }
  cam.endHUD();


  // ækvator
  beginShape();
  noFill();
  stroke(255);
  strokeWeight(3);
  for (int i = 1; i< 24; i++) {
    curveVertex((430+6371)*scale * sin(0.1*PI*i), 0, (430+(6371))*scale * cos(0.1*PI*i));
  }
  endShape();
}

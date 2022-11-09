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
float animeTest = 0; // test variabel
float scale;
String sat_input;
String[] satIDArr;
Satelite[] satArr;

void setup () {
  scale =0.01*width/1920; //

satIDArr = new String[2];
satIDArr[0] = "25544";
satIDArr[1] = "36516";
  
  satArr = new Satelite[2];
  
  for (int i = 0; i < satIDArr.length; i++){
    satArr[i] = new Satelite(satIDArr[i],scale);
  }
  
  
  //Setup for can and progress bar
  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);
  dialog.setProgress(10);
  dialog.setMessage("Loading cam");
  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(350);
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
  for (Satelite sat : satArr){
    sat.drawSat();
  }

  //draws the GUI with the information about the satelites
  cam.beginHUD();
  fill(64, 64, 64);
  stroke (128, 128, 128);
  rect (15, 12, 160*satArr.length, 90, 20);
  noStroke();
  textSize(40);
  for ( int i = 0; i < satArr.length; i++){
    fill(satArr[i].satColor);
  rect (30, 27*(i+1), 20, 20);
  fill (255, 255, 255);
  text (satArr[i].satName, 60, 50+40*i);
    
  }
   cam.endHUD();
  
  
  /*
  fill(sat2.satColor);
  rect (30, 67, 20, 20);
  fill (255, 255, 255);
  text (sat2.satName, 60, 90);
 */
  
    // Ekvator
   beginShape();
        noFill();
        stroke(255);
        strokeWeight(3);
        for(int i = 1; i< 24; i++) { 
            curveVertex((430+6371)*scale * sin(0.1*PI*i), 0, (430+(6371))*scale * cos(0.1*PI*i));
        }
        endShape();

  
  
}

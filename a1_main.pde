import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;
import peasy.*;



Satelite hi;
PeasyCam cam;

PShape globe;
PShape space;
PImage earth;
PImage Space;



void setup () {
  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);


  dialog.setProgress(10);

  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(350);
  cam.setMaximumDistance(3000);

  fullScreen (P3D);

  Space = loadImage ("data/Space.jpg");
  earth = loadImage("data/earth.jpg" );

  globe = createShape (SPHERE, 230);
  globe.setTexture (earth);
  globe.setStroke (false);


  space = createShape (SPHERE, 4000);
  space.setTexture (Space);
  space.setStroke (false);
  

  hi = new Satelite("");

  delay(1000);

  dialog.setProgress(120);

  dialog.setMessage("Ready");
  delay(1000);

  dialog.close();
}

void draw() {

// Contructer vores jord klode og rum
  pushMatrix();
  translate(0, 0, 0);
  shape (globe);
  shape (space);
  translate(0, 0, 2550);
  sphere (40);
  noStroke ();
  fill (128, 128, 128);
  popMatrix();
  
  cam.beginHUD();

  textSize(40);
  rectMode (CORNER);
  fill (255, 255, 255);
  text ("Vi skal lige skrive den der", 30, 50);
  text ("Satelit information her", 30, 90);

  cam.endHUD();
  

  
  
}

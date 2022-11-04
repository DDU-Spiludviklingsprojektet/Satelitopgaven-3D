import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;



Satelite hi;

PShape globe;
PImage earth;
PImage Space;
float angle;


void setup (){
  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);
  
 
  dialog.setProgress(10);
  
  size (1920,1000,P3D);
  Space = loadImage ("data/Space.jpg");
  Space.resize(width, height);
  background (Space);
  earth = loadImage("data/earth.jpg" );
  globe = createShape (SPHERE, 230);
  globe.setTexture (earth);  
  globe.setStroke (false);
  
  hi = new Satelite("");
  println(hi.satName);
  
  
  delay(1000);
  
  dialog.setProgress(120);
  
  dialog.setMessage("Ready");
  delay(1000);
  
  dialog.close();
  
}

void draw() {
  translate(width/2, height/2);
  rotateY (angle);
  angle += 0.005;
  shape (globe);


  
}

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
PImage earth;
PImage Space;
float angle;
float angleX;


void setup (){
  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);
  
 
  dialog.setProgress(10);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);

  size (1920, 1080, P3D);
  Space = loadImage ("data/Space.jpg");
  Space.resize(width, height);
  earth = loadImage("data/earth.jpg" );
  
  


  
  hi = new Satelite("");
  angleX = 0;
  
  
  delay(1000);
  
  dialog.setProgress(120);
  
  dialog.setMessage("Ready");
  delay(1000);
  
  dialog.close();
  
}

void draw() {


    background (0);
    rotateX(-.5);
    rotateY(-.5);
    pushMatrix();
    translate(width/2, height/2);
    globe = createShape (SPHERE, 230);
    globe.setTexture (earth);  
    globe.setStroke (false);;
    shape (globe);
    popMatrix();    
}




void input()  {
  if (keyPressed){
  switch(keyCode){
  case 37: //Left
    angle -= 0.05;
    break;
  case 39: // right
    angle += 0.05;
    break;
  }
 }
}

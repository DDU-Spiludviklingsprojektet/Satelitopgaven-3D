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
float angleX;


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
  angleX = 0;
  
  
  delay(1000);
  
  dialog.setProgress(120);
  
  dialog.setMessage("Ready");
  delay(1000);
  
  dialog.close();
  
}

void draw() {
  translate(width/2, height/2);
  input();
  rotateY (angle);
  //rotateX (angleX);
 // angle += 0.005;
  shape (globe);


  
}

void input()
{
  if (keyPressed){
  switch(keyCode){
  case 37: //Left
    angle -= 0.005;
    break;
  case 39: // right
    angle += 0.005;
    break;
    /*
  case 38: // up
    angleX += 0.005;
    break;
  case 40: //down
    angleX -= 0.005;
    break;
    */
  }
  }
}

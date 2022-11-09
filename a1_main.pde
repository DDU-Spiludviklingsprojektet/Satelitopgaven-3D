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
float animeTest; // test variabel
float scale;
String sat_input;


void setup () {
  sat_input = new UiBooster().showTextInputDialog("Hvilke satteliter vil du tracke: (satelit id)");
  String[] sat_arr = sat_input.split(", ");
  
  printArray(sat_arr);

  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);


  dialog.setProgress(10);

  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(350);
  cam.setMaximumDistance(3000);

  fullScreen (P3D);

  Space = loadImage ("data/Space.jpg");
  earth = loadImage("data/earth.jpg" );


  scale =  (width/20)/(6.371*1000000); //pixel/km

  globe = createShape (SPHERE, scale*(6.371*1000000));
  globe.setTexture (earth);
  globe.setStroke (false);


  space = createShape (SPHERE, 4000);
  space.setTexture (Space);
  space.setStroke (false);


  sat1 = new Satelite("25544",scale);
  sat2 = new Satelite("36516",scale);

  delay(1000);

  dialog.setProgress(120);

  dialog.setMessage("Ready");
  delay(1000);

  dialog.close();
  animeTest = 0;
}

void draw() {
  //draws globe and the space around
  pushMatrix();
  translate(0, 0, 0);
  shape (globe);
  shape (space);
  popMatrix();

  //draws the satelites and the trajectory
  sat1.drawSat(); //cos(PI*animeTest)*260, 0, sin(PI*animeTest)*260
  sat2.drawSat();

  animeTest += 0.001;

  //draws the GUI with the information about the satelites
  cam.beginHUD();

  fill(64, 64, 64);
  stroke (128, 128, 128);
  rect (15, 12, 200, 90, 20, 20, 20, 20);

  noStroke();
  textSize(40);

  fill(sat1.satColor);
  rect (30, 27, 20, 20);
  fill (255, 255, 255);
  text (sat1.ID, 60, 50);

  fill(sat2.satColor);
  rect (30, 67, 20, 20);
  fill (255, 255, 255);
  text (sat2.ID, 60, 90);

  cam.endHUD();
}

import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;



Satelite hi;


void setup() {
  ProgressDialog dialog = new UiBooster().showProgressDialog("Please wait", "Waiting", 0, 100);
  fullScreen(P3D);
  
  dialog.setProgress(10);

  hi = new Satelite("");
  println(hi.satName);
  
  
  
  
  delay(1000);
  
  dialog.setProgress(120);
  
  dialog.setMessage("Ready");
  delay(1000);
  
  dialog.close();
  
}

void draw() {
  
}

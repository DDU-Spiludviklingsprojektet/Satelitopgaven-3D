class Satelite {
  Position[] posList;
  String satName;
  String ID;
  float avgIncLat;
  float avgIncLon;
  color satColor;
  float rotZ;
  float rotX;

  Satelite(String satID, float rotX, float rotZ)
  {
    this.ID = satID;
    getJ(this, satID);
    satColor = color(random(70,200),random(70,200),random(70,200));
    this.rotX = rotX;
    this.rotZ = rotZ;
  }

  void drawSat(float x, float y, float z){
    
    pushMatrix();
    stroke(satColor);
     rotateZ(rotZ);
     rotateX(rotZ);
    
    translate(x,y,z);
    fill(255);
    box(10);
    popMatrix();
   this.orbitalDraw();
  }
  
  void orbitalDraw(){
    
     pushMatrix();
 
     rotateZ(rotZ);
     rotateX(rotZ);
  
  beginShape();
        noFill();
        
        strokeWeight(6);
        for(int i = 1; i< 24; i++) {
            curveVertex((230 + 30) * sin(0.1*PI*i), 0, (230+30) * cos(0.1*PI*i));
        }
        endShape();

  popMatrix();
    
  }
}

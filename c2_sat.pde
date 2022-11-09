class Satelite {
  PVector[] posList;
  String satName;
  String ID;
  color satColor;
  float rotZ;
  float rotX;
  float scale;
  float alt;

  Satelite(String satID,float scale)
  {
    this.ID = satID;
    getJ(this, satID);
    satColor = color(random(70,200),random(70,200),random(70,200));
    this.scale = scale;
    calcRot();
  }

void calcRot(){
  PVector diff = PVector.sub(posList[1],posList[0]);
  this.rotZ = atan(diff.y/diff.x);
  this.rotX = -1 *atan(diff.y/diff.x); 
  
}


  void drawSat(){
  
    pushMatrix();
    stroke(satColor);
     //rotateZ(rotZ);
     //rotateX(rotX);
   

    //translate(posList[0].x*0.5*scale+scale,posList[0].y*0.5*scale+scale,posList[0].z*0.5*scale+scale);
    
    //translate(,alt*scale,alt);

    fill(255);
    box(10);
    popMatrix();

   this.orbitalDraw();
  }
  
  void orbitalDraw(){
    
     pushMatrix();
 
     rotateZ(rotZ);
     rotateX(rotX);
  
  beginShape();
        noFill();
        
        strokeWeight(6);
        for(int i = 1; i< 24; i++) { // this.scale*10 + 
            curveVertex((alt*scale+scale*(6.371*1000000)) * sin(0.1*PI*i), 0, (alt*scale+scale*(6.371*1000000)) * cos(0.1*PI*i));
        }
        endShape();

  popMatrix();
    
  }
}

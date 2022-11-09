class Satelite {
  PVector[] posList;
  String satName;
  String ID;
  color satColor;
  float rotZ;
  float rotX;
  float scale;
  float alt;
  float lat;
  float lon;
  float rotY;
  float animeTest;

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
  //PVector diff = this.posList[0].get();
  this.rotZ = atan(diff.y/diff.x);
  this.rotX = -atan(diff.y/diff.z); 
  this.rotY = -atan(diff.z/diff.x);  //virker ikke?
 println(rotX,rotY,rotZ);
  
   
}


  void drawSat(){
  
    pushMatrix();
    stroke(satColor);
   // rotateZ(rotZ);
    //rotateX(rotX);
    //rotateY(PI);

    //translate(posList[0].x*0.5*scale+scale,posList[0].y*0.5*scale+scale,posList[0].z*0.5*scale+scale);
    
    translate(this.posList[0].x,this.posList[0].y,this.posList[0].z);

    fill(255);
    box(10);
    popMatrix();

   this.orbitalDraw();
  }
  
  void orbitalDraw(){
    
     pushMatrix();
 
    rotateZ(rotZ);
     rotateX(rotX);
     rotateY(rotY);
  
  beginShape();
        noFill();
        
        strokeWeight(6);
        
        for(int i = 1; i< 24; i++) { 
         
           curveVertex((alt+6371)*scale * sin(0.1*PI*i), 0, (alt+(6371))*scale * cos(0.1*PI*i));
        }
        endShape();

  popMatrix();
    
  }
}

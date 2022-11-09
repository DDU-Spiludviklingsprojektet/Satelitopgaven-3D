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
  //this.rotY = atan(diff.z/diff.x);  //virker ikke?
 println(rotX,rotY,rotZ);
  
   
}


  void drawSat(){
  
    pushMatrix();
    stroke(satColor);
   // rotateZ(rotZ);
    //rotateX(rotX);
    //rotateY(PI);

    //translate(posList[0].x*0.5*scale+scale,posList[0].y*0.5*scale+scale,posList[0].z*0.5*scale+scale);
    
    translate(this.posList[1].x,this.posList[1].y,this.posList[1].z);

    fill(255);
    box(10);
    popMatrix();

   this.orbitalDraw();
  }
  
  void orbitalDraw(){
    
     pushMatrix();
 
    //rotateZ(rotZ);
     //rotateX(rotX);
     //rotateY(guh);
  
  beginShape();
        noFill();
        
        strokeWeight(6);
        for(int i = 1; i< 24; i++) { 
          float h = 6371*scale+alt*scale;
           //PVector guh = convert(this.lat+0.1*PI*i,this.lon+0.1*PI*i,h);
            
          float theta = lat +0.1*PI*i;//-radians(10);
          float phi = lon + PI +0.1*PI*i;

  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
            float x = h * cos(theta) * cos(phi);
            float y = -h * sin(theta);
            float z = -h * cos(theta) * sin(phi);
           curveVertex(x,y,z);
          
           // old: curveVertex((alt+6371)*scale * sin(0.1*PI*i), 0, (alt+(6371))*scale * cos(0.1*PI*i));
        }
        endShape();

  popMatrix();
    
  }
}

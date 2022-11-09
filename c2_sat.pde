class Satelite {
  PVector[] posList;
  String satName;
  String ID;
  color satColor;
  float rotZ;
  float rotX;
  float scale;
  float alt;
  float rotY;

  Satelite(String satID,float scale)
  {
    this.ID = satID;
    getJ(this, satID); // downloader satelittens data med den selv som argument
    satColor = color(random(70,200),random(70,200),random(70,200));
    this.scale = scale;
    calcRot();
  }

void calcRot(){ // udregner rotation, idet satellittens bane tegnes om ækvator og drejes bagefter.
  PVector diff = PVector.sub(posList[1],posList[0]);
  this.rotZ = atan(diff.y/diff.x);
  this.rotX = -atan(diff.y/diff.z); 
  this.rotY = -atan(diff.z/diff.x);  

  
   
}


  void drawSat(){ // tegner sattelittes i det første punkt som blev sendt tilbage fra JSON dataen
  
    pushMatrix();
    stroke(satColor);
    translate(this.posList[0].x,this.posList[0].y,this.posList[0].z);

    fill(255);
    box(10);
    popMatrix();

   this.orbitalDraw(); // tegner orbital/kredsløb
  }
  
  void orbitalDraw(){
    
     pushMatrix();
    rotateZ(rotZ);
     rotateX(rotX);
     rotateY(rotY);
  
  beginShape(); // danner en cirkel ud fra en masse punkter med satellittens altitude som radius.
        noFill();
        
        strokeWeight(6);
        
        for(int i = 1; i< 24; i++) { 
         
           curveVertex((alt+6371)*scale * sin(0.1*PI*i), 0, (alt+(6371))*scale * cos(0.1*PI*i));
        }
        endShape();

  popMatrix();
    
  }
}

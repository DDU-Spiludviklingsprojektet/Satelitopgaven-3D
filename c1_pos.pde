class Position {
  float lat;
  float lon;
  float elevation;
  
  Position(JSONObject json){
    this.lat = json.getFloat("satlatitude");
    this.lon = json.getFloat("satlongitude");
    //this.elevation = json.getFloat("elevation");
  }
  
  
  
}

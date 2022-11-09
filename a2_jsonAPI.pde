
void getJ(Satelite sat, String satID) {
  if (satID.length() <=0) {
    satID = "25544";
  }
  sat.ID = satID;
  JSONObject json = loadJSONObject("http://104.248.161.215:5000/api/"+satID);
  sat.satName = json.getString("Name");
  JSONArray posArr = json.getJSONArray("pos");
  PVector[] posList = new PVector[2];
  for(int i = 0; i<posArr.size(); i++) {
   float lat = posArr.getJSONArray(i).getFloat(0)/1000;
   float lon = posArr.getJSONArray(i).getFloat(1)/1000;
   float alt = posArr.getJSONArray(i).getFloat(2)/1000;
    posList[i] = convert(lat, lon, alt);
    println(posList[i],alt);
    sat.alt = alt;
    sat.lat = lat;
    sat.lon = lon;
  }
  sat.posList = posList;
}

PVector convert(float lat, float lon, float h ) {
  float theta = lat;
  float phi = lon + PI;

  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
  float x = h * cos(theta) * cos(phi);
  float y = -h * sin(theta);
  float z = -h * cos(theta) * sin(phi);
  
  return new PVector(x, y, z);
}

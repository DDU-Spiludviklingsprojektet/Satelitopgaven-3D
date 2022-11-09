
void getJ(Satelite sat, String satID) {
  if (satID.length() <=0) {
    satID = "25544";
  }
  sat.ID = satID;
  JSONObject json = loadJSONObject("http://104.248.161.215:5000/api/"+satID);
  sat.satName = info.getString("Name");
  JSONArray posArr = json.getJSONArray("pos");
  PVector[] posList = new PVector[2];
  for(int i = 0; i<posArr.length; i++) {
    lat = posArr.getJSONArray(i).getFloat(0);
    lon = posArr.getJSONArray(i).getFloat(1);
    alt = posArr.getJSONArray(i).getFloat(2);
    posList[i] = convert(lat, alt, lon);
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

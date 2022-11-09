//This connects the processing program to our server, via the API in the python script in apiserver.py
//It also splits and modifies the data for use by the program.

//The function for get JSON, called by each sattelite
void getJ(Satelite sat, String satID) {
  if (satID.length() <=0) {
    satID = "25544";
  }
  //Selects the JSON data, which is formatted in the following form:
  //{"Name":"SPACE STATION","pos":[[-2.9853627681732178,0.6869940161705017,418941.96875],[-2.921661853790283,0.6454346179962158,418755.125]]}
  sat.ID = satID;
  JSONObject json = loadJSONObject("http://104.248.161.215:5000/api/"+satID);
  sat.satName = json.getString("Name");
  JSONArray posArr = json.getJSONArray("pos");
  PVector[] posList = new PVector[2];
  for(int i = 0; i<posArr.size(); i++) {
   float lat = posArr.getJSONArray(i).getFloat(0)/1000;
   float lon = posArr.getJSONArray(i).getFloat(1)/1000;
   float alt = posArr.getJSONArray(i).getFloat(2)/1000;
    posList[i] = convert(lat, lon, 6371*scale+alt*scale);
    println(posList[i],alt);
    sat.alt = alt;
    sat.lat = lat;
    sat.lon = lon;
  }
  sat.posList = posList;
}

//Creates a PVector with the array of the data, to make it easier to modify the data. 
PVector convert(float lat, float lon, float h ) {
  float theta = lat;//-radians(10);
  float phi = lon + PI;

  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
  float x = h * cos(theta) * cos(phi);
  float y = -h * sin(theta);
  float z = -h * cos(theta) * sin(phi);
  
  return new PVector(x, y, z);
}

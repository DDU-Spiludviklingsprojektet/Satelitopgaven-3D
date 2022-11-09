
void getJ(Satelite sat, String satID) {
  if (satID.length() <=0) {
    satID = "25544";
  }
  sat.ID = satID;
  String api = "M9GF6D-XSLVGS-LZ2YYR-4Y5P";
  int requests = 2;
  JSONObject json = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/"+satID+"/41.702/-76.014/0/"+str(requests)+"/&apiKey="+api);

  /*
{
   "info": {
   "satname": "SPACE STATION",
   "satid": 25544,
   "transactionscount": 5
   },
   "positions": [
   {
   "satlatitude": -39.90318514,
   "satlongitude": 158.28897924,
   "sataltitude": 417.85,
   "azimuth": 254.31,
   "elevation": -69.09,
   "ra": 44.77078138,
   "dec": -43.99279118,
   "timestamp": 1521354418
   },
   {
   "satlatitude": -39.86493451,
   "satlongitude": 158.35261287,
   "sataltitude": 417.84,
   "azimuth": 254.33,
   "elevation": -69.06,
   "ra": 44.81676119,
   "dec": -43.98086419,
   "timestamp": 1521354419
   }
   ]
   }
   */
   
   
  JSONObject info = json.getJSONObject("info");
  sat.satName = info.getString("satname");
  JSONArray posArr = json.getJSONArray("positions");
  //Position[] posList = new Position[posArr.size()];
  PVector[] posList = new PVector[2];
  for (int i = 0; i < 2; i++) {
    JSONObject jPos = posArr.getJSONObject(i);
     sat.alt = jPos.getFloat("sataltitude");
    posList[i] = convert(jPos.getFloat("satlatitude"),jPos.getFloat("sataltitude"),jPos.getFloat("satlongitude"));
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

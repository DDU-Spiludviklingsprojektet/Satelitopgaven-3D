void getJ(Satelite sat, String satID)
{
  if (satID.length() <=0) 
      {satID = "25544";}

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
  Position[] posList = new Position[posArr.size()];
  for (int i = 0; i < posArr.size(); i++)
  {
    JSONObject jPos = posArr.getJSONObject(i);
    Position pos = new Position(jPos);
    posList[i] = pos;
  }
  sat.posList = posList;
}

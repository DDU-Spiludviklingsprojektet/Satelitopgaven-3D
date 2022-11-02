class Satelite {
  Position[] posList;
  String satName;
  String ID;
  float avgIncLat;
  float avgIncLon;

  Satelite(String satID)
  {
    this.ID = satID;
    getJ(this,satID);
    getAvg();
  }
  
  void getAvg()
  {
    float latDiffSum = 0;
    float lonDiffSum = 0;
    for (int i = 0; i < posList.length -1; i++)
    {
      Position pos1 = posList[i];
      Position pos2 = posList[i+1];
      latDiffSum += pos2.lat - pos1.lat;
      lonDiffSum += pos2.lon - pos1.lon;
    }
    this.avgIncLat = latDiffSum / posList.length;
    this.avgIncLon = lonDiffSum / posList.length;
  }
  
  
}

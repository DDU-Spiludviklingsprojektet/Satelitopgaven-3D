import json, urllib.request, ephem
from sgp4.api import Satrec
from sgp4.api import jday
import pyorbital
from pyorbital.orbital import Orbital
from datetime import datetime



orb = Orbital("Suomi NPP")
now = datetime.utcnow()
orb.get_lonlatalt(now)

print("here!")
# Get TLE data from Celestrak
satnumber = "25544"
with urllib.request.urlopen("https://api.n2yo.com/rest/v1/satellite/tle/"+satnumber+"&apiKey=M9GF6D-XSLVGS-LZ2YYR-4Y5P") as url:
    data = json.load(url)

g = data["tle"].split("\n")
line1 = g[0]
line2 = g[1]

satellite = Satrec.twoline2rv(line1, line2)
jd, fr = jday(2023, 12, 9, 12, 0, 0)
e, r, v = satellite.sgp4(jd,fr)
alt = (float(r[1])*-1)-6378.137
print(alt)
#print(v)

name = "ISS (ZARYA)";
#line1 = "1 25544U 98067A   12304.22916904  .00016548  00000-0  28330-3 0  5509";
#line2 = "2 25544  51.6482 170.5822 0016684 224.8813 236.0409 15.51231918798998";
tle_rec = ephem.readtle(name, line1, line2);
tle_rec.compute();
print(tle_rec.sublong, tle_rec.sublat);

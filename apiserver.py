# This is our api for the sattelite position. It gets a sattelite ID,
# For this sattelite ID, it requests the TLE from a third party, which is returned
# And then is translated to the data we need.
# You can try the api with http://104.248.161.215/api/[sat_ID]
# The data will be returned as JSON in the following form:
# {"Name":"SPACE STATION","pos":[[-2.9853627681732178,0.6869940161705017,418941.96875],[-2.921661853790283,0.6454346179962158,418755.125]]}
# encoding: utf-8
# importing a lot of stuff, python things
from flask import Flask, jsonify, request
import json, urllib.request, ephem
from datetime import datetime
import datetime as dt

#Function to calculate the coordiantes and altidude of a satellite
def calculate(satnumber):
    #Getting the TLE data from n2yo api
    with urllib.request.urlopen("https://api.n2yo.com/rest/v1/satellite/tle/"+str(satnumber)+"&apiKey=M9GF6D-XSLVGS-LZ2YYR-4Y5P") as url:
        data = json.load(url)
    #Getting the name of the satellite from the JSON data
    name = data["info"]["satname"]
    #Splitting the TLE data into, well, two elements
    g = data["tle"].split("\n")
    line1 = g[0]
    line2 = g[1]

    #Creating a satellite object with the ephem library
    tle_rec = ephem.readtle(name, line1, line2);

    #Getting the current time
    start_dt = dt.datetime.now()
    #Selects the interval of time between the two returns
    intervall = dt.timedelta(minutes=1)

    #creating a list of the different times we want to calculate the coordinates for
    timelist = []
    for i in range(2):
        timelist.append(start_dt + i*intervall)

    #Creating a list of the coordinates and altitudes
    positions = []
    #appends the name of the object to the start of the list.
    #positions.append(name)
    for t in timelist:
        tle_rec.compute(t)
        positions.append((tle_rec.sublong,tle_rec.sublat,tle_rec.elevation))
    
    return positions,name

app = Flask(__name__)

#Creates the webserver for our own api
@app.route('/api/<id>', methods=['GET'])
def post(id):
    idList = id.split("-")
    data = {}
    for x in idList:
        positions, name = calculate(x)
        data["Name"] = name
        data["pos"] = positions
    return jsonify(data)

app.run(host="0.0.0.0", port=5000)

#Now you may be asking, why did you make this API, it does excatly the same as you could with N2YO. We have been thinking the same. But we originally created it since it would allow us to customise and get data in ways you couldn't get with N2YO. But due to time constraints we had to limit the scope, and all of the "extra" ideas were scrapped. Still it allows for some cool features, such as custom time intervals between each position, that you cant do with N2YO.

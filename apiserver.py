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
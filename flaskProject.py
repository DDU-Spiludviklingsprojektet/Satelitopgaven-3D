# encoding: utf-8
import json
from flask import Flask, jsonify, request
import json, urllib.request, ephem
from datetime import datetime
import datetime as dt

app = Flask(__name__)


@app.route('/api/<id>', methods=['GET'])
def post(id, speed):
    idList = id.split("-")
    calculate()
    data = {}
    for x in idList:
        data[x] = calculate(x)
    return jsonify(data)


app.run(host="0.0.0.0", port=5000)


def calculate(satnumber):
    with urllib.request.urlopen("https://api.n2yo.com/rest/v1/satellite/tle/"+satnumber+"&apiKey=M9GF6D-XSLVGS-LZ2YYR-4Y5P") as url:
        data = json.load(url)
    name = data["info"]["satname"]
    g = data["tle"].split("\n")
    line1 = g[0]
    line2 = g[1]

    tle_rec = ephem.readtle(name, line1, line2);
    tle_rec.compute();
    print(name);
    #print(tle_rec.sublong, tle_rec.sublat);

    start_dt = dt.datetime.now()
    intervall = dt.timedelta(minutes=1)

    timelist = []
    for i in range(2):
        timelist.append(start_dt + i*intervall)

    positions = []
    for t in timelist:
        tle_rec.compute(t)
        positions.append((tle_rec.sublong,tle_rec.sublat,tle_rec.elevation))

    return positions

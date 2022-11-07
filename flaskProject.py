# encoding: utf-8
import json
from flask import Flask, jsonify, request
app = Flask(__name__)


@app.route('/api/<id>/<speed>', methods=['GET'])
def post(id, speed):
    idList = id.split("-")
    data = {}
    for x in idList:
        data[x] = "some data for " + x
    return jsonify(data)


app.run(host="0.0.0.0", port=5000)

from flask import Flask, request, jsonify
from redis import Redis

app = Flask(__name__)
redis = Redis(host="redis", db=0, socket_timeout=5, charset="utf-8", decode_responses=True)

@app.route('/', methods=['POST', 'GET'])
def index():

    if request.method == 'POST':
            name = request.json['name']
            redis.rpush('students', "\{'name':"+name+"\}")
            return jsonify({'name': name})

    if request.method == 'GET':
            return jsonify(redis.lrange('students', 0, -1))

from urllib import response
from flask import Flask, jsonify, request
import json

response = ''
app = Flask(__name__)

@app.route('/link', methods = ['GET', 'POST'])
def linkRoute():
    global response

    if(request.method == 'POST'):
        print('post')
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        link = request_data['link']
        response = f'{link}'
        return " "
    else:
        return jsonify({'link': response})

if __name__ == "__main__":
    app.run(debug=True)
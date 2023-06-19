from flask import Flask, jsonify
import socket
import datetime
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

@app.route('/timestamphostname', methods=['GET'])
def get_data():
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    hostname = socket.gethostname()
    data = {
        'timestamp': timestamp,
        'hostname': hostname
    }
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

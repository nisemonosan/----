from flask import Flask, jsonify, request
import api  # api.pyをインポート
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/stores", methods=["GET"])
def get_stores():
    stores = api.get_all_stores()
    response = jsonify(stores)
    response.headers.add("Access-Control-Allow-Origin", "*") 
    return response

@app.route("/store", methods=["POST"])
def add_store():
    data = request.get_json()
    name = data.get("name")
    address = data.get("address")
    category = data.get("category")
    budget = data.get("budget")
    memo = data.get("memo")
    check = data.get("check", False)
    api.add_store(name, address, category, budget, memo, check)
    return jsonify({"message": "Store added successfully"}), 201

@app.route("/store/<int:store_id>", methods=["PUT"])
def update_store(store_id):
    data = request.get_json()
    name = data.get("name")
    address = data.get("address")
    category = data.get("category")
    budget = data.get("budget")
    memo = data.get("memo")
    check = data.get("check")
    success = api.update_store(store_id, name, address, category, budget, memo, check)
    if success:
        return jsonify({"message": "Store updated successfully"})
    else:
        return jsonify({"message": "Store not found"}), 404

@app.route("/store/<int:store_id>", methods=["DELETE"])
def delete_store(store_id):
    success = api.delete_store(store_id)
    if success:
        return jsonify({"message": "Store deleted successfully"})
    else:
        return jsonify({"message": "Store not found"}), 404
    
@app.route("/distance", methods=["POST"])
def calculate_locate():
    data = request.get_json()
    current_location = data.get("current_location")
    destination_address = str(data.get("destination_address"))

    if not current_location or not destination_address:
        return jsonify({"error": "Invalid input data"}), 400

    current_lat, current_lon = current_location
    distance = api.calculate_distance(current_lat, current_lon, destination_address)

    if distance is not None:
        response = jsonify({"distance": distance}), 200
        return response
    else:
        response = jsonify({"error": "Failed to calculate distance"}), 500
        return response
    

if __name__ == '__main__':
    app.run(host='127.0.0.1',debug=True)

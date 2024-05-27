import sqlite3
from geopy.geocoders import Nominatim
from geopy.distance import geodesic
import math
import re
import geocoder

db_file = 'store_info.db'
conn = sqlite3.connect(db_file)
c = conn.cursor()

create_table_sql = '''
CREATE TABLE IF NOT EXISTS store (
    id PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    category TEXT,
    budget TEXT,
    memo TEXT,
    checked INTEGER NOT NULL DEFAULT 0
)
'''

# テーブルを作成
c.execute(create_table_sql)
conn.commit()

def add_store(name, address, category=None, budget=None, memo=None, checked=None):
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    insert_sql = '''
    INSERT INTO store (name, address, category, budget, memo, checked)
    VALUES (?, ?, ?, ?, ?, ?)
    '''
    c.execute(insert_sql, (name, address, category, budget, memo, checked))
    conn.commit()
    conn.close()

conn.close()


# データを編集する関数
def update_store(store_id, name=None, address=None, category=None, budget=None, memo=None, check=None):
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    
    # 現在のデータを取得
    c.execute("SELECT name, address, category, budget, memo, check FROM store WHERE id = ?", (store_id,))
    current_data = c.fetchone()
    
    if not current_data:
        conn.close()
        return False  # 指定されたIDのデータが存在しない場合
    
    # 新しいデータが入力されていない場合は現在のデータを使用
    new_data = (
        name if name is not None else current_data[0],
        address if address is not None else current_data[1],
        category if category is not None else current_data[2],
        budget if budget is not None else current_data[3],
        memo if memo is not None else current_data[4],
        check if check is not None else current_data[5],
        store_id
    )
    
    update_sql = '''
    UPDATE store
    SET name = ?, address = ?, category = ?, budget = ?, memo = ?, check = ?
    WHERE id = ?
    '''
    c.execute(update_sql, new_data)
    conn.commit()
    conn.close()
    return True

# データを削除する関数
def delete_store(store_id):
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    delete_sql = '''
    DELETE FROM store WHERE id = ?
    '''
    c.execute(delete_sql, (store_id,))
    conn.commit()
    conn.close()
    return c.rowcount > 0  # 削除された行数が0より大きい場合はTrueを返す

def get_all_stores():
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    select_sql = '''
    SELECT * FROM store
    '''
    c.execute(select_sql)
    all_stores = c.fetchall()
    conn.close()
    return all_stores

geolocator = Nominatim(user_agent="gtest")


"""
def get_coordinates(address:str):
    print(address)
    location = geocoder.osm(address,timeout=5.0)
    print(address,location.latlng)
    return (location.latlng) if location else None

def calculate_distance(current_lat,current_lon, destination_address):
    destination_location = get_coordinates(destination_address)
    if destination_location:
        destination_lat, destination_lon = destination_location
        distance = geodesic((current_lat, current_lon), (destination_lat, destination_lon)).meters
        distance = math.floor(distance)
        if distance >= 1000:
           distance = str(round(distance / 1000, 1)) + 'km'
        else:
            distance = str(distance) + 'm'
        return distance
    else:
        return None"""
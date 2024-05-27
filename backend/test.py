import geocoder

address = '愛知県'
location = geocoder.osm(address,timeout=5.0)
print(address,location.latlng)
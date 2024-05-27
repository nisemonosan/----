import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'package:namer_app/add.dart';

var apiUrl= 'http://127.0.0.1:5000';
List<Map<String, dynamic>> fetchedData = []; // 一時的にデータを保存する変数


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GohanMemo',
      theme: ThemeData(
        fontFamily: 'LINESeed',
      ),
      home: Home(),
    );
  }
}


class Home extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            actions: [IconButton(icon: Icon(Icons.sort),onPressed: (){},)],
            backgroundColor: Colors.grey[50],
            elevation: 1,
          ),
          backgroundColor: Color.fromARGB(255, 239, 243, 255),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                child: Text(
                'Check!',
                textAlign: TextAlign.left,
                style:TextStyle(
                  color:Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                )),
              ),

              Expanded(
                child: FutureBuilder(
                  future: fetchStores(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<Map<String, dynamic>> stores = snapshot.data;
                          
                            return ListView.builder(
                              itemCount: stores.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  child:ListTile(
                                    tileColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: Text(stores[index]['name'],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromARGB(255, 5, 42, 155)),),
                                    subtitle:Column(
                                      children: [
                                        Row(
                                          children:[
                                            Container(
                                              padding: EdgeInsets.only(left:2,right: 2),
                                              child:Icon(Icons.location_on_outlined,size:22),),
                                        
                                            Container(child:Text(stores[index]['address'],style:TextStyle(fontSize: 16,fontWeight: FontWeight.normal))),
                                          ]
                                        ),

                                        Container(
                                          child: FutureBuilder(
                                            future: calculateDistance(stores[index]['locate'], stores[index]['address']),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.done) {
                                                if (snapshot.hasData) {
                                                  return Text(snapshot.data.toString());
                                                } else if (snapshot.hasError) {
                                                  return Text('Error: ${snapshot.error}');
                                                }
                                              }
                                              return CircularProgressIndicator();
                                            },
                                          ),
                                        )
                                      ]
                                    )
                                  )
                                );
                              },
                            );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                ),
              )
            ]
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 0,
            backgroundColor: Colors.yellow,
            child: const Icon(Icons.add),
          )
    );
  }

  Future fetchStores() async {
     Position locate = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Map<String, dynamic>> stores = []; // storesリストの要素をMap型に変更
    final response = await http.get(Uri.parse('$apiUrl/stores'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      stores = List<Map<String, dynamic>>.from(data.map((item) => {
        'id': item[0],
        'name': item[1],
        'address': item[2],
        'category': item[3],
        'budget': item[4],
        'memo': item[5],
        'checked': item[6],
        'locate': [locate.latitude, locate.longitude],
      })); // 店名と住所のみを取得して格納
      return stores;
    } else {
      return Exception('Failed to load stores');
    }
  }

  Future calculateDistance(locate,target) async {
    final response = await http.post(Uri.parse('$apiUrl/distance'),
    headers: {'Content-type':'application/json; charset=UTF-8',},
    body: jsonEncode({
      'current_location': [locate[0],locate[1]],
      'destination_address': target,
    }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var distance = data['distance'];
      return distance;
    } else {
      return Exception('Failed to calculate distance');
    }
  }
}




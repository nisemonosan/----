

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:namer_app/database.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.id});
  final int id;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail>{
  List store = [];
  var url = '';

  @override
    void initState() {
      super.initState();
      GohannDB.openDb();
      fetchStore();
  }
  Future<void> fetchStore() async {
    Map<String, dynamic> fetchedStore = await GohannDB.getStoreById(widget.id);
    setState(() {
      store = [fetchedStore];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Title(color:Colors.black, child: Text('店の詳細')),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.grey[50],
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(store[0]['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(255, 5, 42, 155)),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                    Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=${store[0]['address']}');
                    launchUrl(url);
                  },
                  child: Row(
                    children: [
                      SizedBox(child:Icon(Icons.location_on_outlined,size:30)),
                      SizedBox(child:Text('${store[0]['address']}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)))
                    ],
                  ),
                )
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text('カテゴリー'),
                          if (store[0]['category'] == null)  Text('未設定') else Text('${store[0]['category']}')
                        ],
                      ),
                    ),
                ],),
              )
            ],
          ),
        )
      ),
    );
  }
}
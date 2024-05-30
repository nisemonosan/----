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
              )
            ],
          ),
        )
      ),
    );
  }
}
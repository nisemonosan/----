import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:namer_app/add.dart';
import 'package:namer_app/database.dart'; // データベース関連のファイルをインポート


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
     ThemeMode mode = ThemeMode.system;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GohanMemo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: mode,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> stores = [];

  @override
  void initState() {
    super.initState();
    GohannDB.openDb();
    fetchStores();
  }

  Future<void> fetchStores() async {
    List<Map<String, dynamic>> fetchedStores = await GohannDB.getAllStores();
    setState(() {
      stores = fetchedStores;
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
      backgroundColor: Color.fromARGB(255, 239, 243, 255),
      body: 
        Container(
          child:Scrollbar(
            controller: scrollController,
            child:Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  child:Text('Check!',textAlign:TextAlign.left,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                    
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await fetchStores();
                    },
                    child:ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: stores.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          child:ListTile(
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                            title: Text('${stores[index]['name']}',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color.fromARGB(255, 5, 42, 155))),
                            subtitle: Row(
                              children: [
                                SizedBox(child:Icon(Icons.location_on_outlined,size:22)),
                                SizedBox(child:Text('${stores[index]['address']}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.normal)))
                              ],)
                          )
                        );
                      }
                    )
                  )
                )
              ],
            )  
          ),
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
      ),
    );
  }
}
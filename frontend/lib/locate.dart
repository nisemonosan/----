import 'package:flutter/material.dart';

class locate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pop();}),
        backgroundColor: Colors.grey[50],
        elevation: 1,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      body: Container(child: Text('test'),)
    );
  }
}
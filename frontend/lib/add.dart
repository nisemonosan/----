import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AddPage extends StatelessWidget {
  String? name,adress,category,budget,memo;
  String? isSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.of(context).pop();},),
        backgroundColor: Colors.grey[50],
        elevation: 1,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child:Container(
          child:Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child:TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[50],
                    labelText: 'Store Name',
                    prefixIcon: Icon(Icons.home_rounded),
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '店名を入力してください',
                    hintStyle: TextStyle(
                      fontSize: 12
                    )
                  ),
                  onChanged: (text) {
                    name = text;
                  },
                )
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    
                    prefixIcon: Icon(Icons.location_on),
                    labelText: 'Adress',
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      
                    ),
                    hintText: '住所を入力してください',
                    hintStyle: TextStyle(
                      fontSize: 12
                    )
                  ),
                  onChanged: (text) {
                    adress = text;
                  },
                )
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[50],
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.home_rounded),
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '店のカテゴリーを入力してください。',
                    hintStyle: TextStyle(
                      fontSize: 12
                    )
                  ),
                  onChanged: (text) {
                    category = text;
                  },
                )
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child:DropdownButtonFormField(
                  items: const[
                    DropdownMenuItem(
                      value: '1円から1,000円',
                      child: Text('1円から1,000円'),
                    ),
                    DropdownMenuItem(
                      value: '1,000円から2,000円',
                      child: Text('1,000円から2,000円'),
                    ),
                    DropdownMenuItem(
                      value: '2,000円から3,000円',
                      child: Text('2,000円から3,000円'),
                    ),
                    DropdownMenuItem(
                      value: '3,000円から5,000円',
                      child: Text('3,000円から5,000円'),
                    ),
                    DropdownMenuItem(
                      value: '5,000円から10,000円',
                      child: Text('5,000円から10,000円'),
                    ),
                    DropdownMenuItem(
                      value: '10,000円以上',
                      child: Text('10,000円以上'),
                    ),
                  ],
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.grey[50],
                    labelText: 'Budget',
                    prefixIcon: Icon(Icons.account_balance_wallet_rounded),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '店の価格帯を選択してください。',
                    hintStyle: TextStyle(
                      fontSize: 12
                    )
                  ),
                  value: isSelectedValue,
                  onChanged: (String? value) {
                    budget = value;
                  },
                )
                  
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    
                    fillColor: Colors.grey[50],
                    labelText: 'Memo',
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '任意で入力してください。',
                    hintStyle: TextStyle(
                      fontSize: 12
                    )
                  ),
                  onChanged: (text) {
                    category = text;
                  },
                )
              ),
            ]
              
          )
        )
        
      )
    );
  }
}


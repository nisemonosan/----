import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:namer_app/database.dart'; // データベース関連のファイルをインポート


class AddPage extends StatelessWidget {
  
  late String name, address;
  String? category, budget, memo;
  String? isSelectedValue;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pop();}),
        backgroundColor: Colors.grey[50],
        elevation: 1,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Container(
          child:Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextFormField(
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '必須項目です。';
                      }
                      return null;
                    },
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
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (text) {
                      name = text;
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '必須項目です。';
                      }
                      return null;
                    },
                    decoration: InputDecoration(

                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Address',
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
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (text) {
                      address = text;
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextFormField(
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
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (text) {
                      category = text;
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: DropdownButtonFormField(
                    items: const [
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
                        fontSize: 12,
                      ),
                    ),
                    value: isSelectedValue,
                    onChanged: (value) {
                      budget = value;
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 140,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.message_rounded),
                      fillColor: Colors.grey[50],
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'メモ : 任意で入力してください。',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (text) {
                      memo = text;
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        GohannDB.addStore(name, address, category: category, budget: budget, memo: memo);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('登録する', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
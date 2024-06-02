import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const dbFile = 'store_info.db';

class GohannDB extends ChangeNotifier {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), dbFile),
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE IF NOT EXISTS store (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            address TEXT NOT NULL,
            category TEXT,
            budget TEXT,
            memo TEXT,
            checked INTEGER NOT NULL DEFAULT 0
        )
      ''');
      },
      version: 1,
    );
  }

  static Future<void> addStore(String name, String address, {String? category, String? budget, String? memo}) async {
    var db = await openDb();
    await db.insert(
      'store',
      {
        'name': name,
        'address': address,
        'category': category,
        'budget': budget,
        'memo': memo,
        'checked': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    }

  static Future<Map<String, dynamic>> getStoreById(int storeId) async {
    var db = await openDb();
    List<Map<String, dynamic>> stores = await db.query('store', where: 'id = ?', whereArgs: [storeId]);
    if (stores.isEmpty) {
      throw Exception('Store with id $storeId not found');
    }
    return stores.first;
  }

  static Future<void> updateStore(int storeId, {String? name, String? address, String? category, String? budget, String? memo, int? check}) async {
    var db = await openDb();
    final Map<String, dynamic> data = {
      'name': name,
      'address': address,
      'category': category,
      'budget': budget,
      'memo': memo,
      'check': check,
    };
    await db.update(
      'store',
      data,
      where: 'id = ?',
      whereArgs: [storeId],
    );
    }

  static Future<List<Map<String, dynamic>>> getAllStores() async {
    var db = await openDb();
    final List<Map<String, dynamic>> stores = await db.query('store');
    return stores;
  }
}






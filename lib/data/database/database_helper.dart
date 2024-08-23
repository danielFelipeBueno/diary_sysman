

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal();
  static DatabaseHelper get instance => _databaseHelper ??= DatabaseHelper._internal();

  Database? _db;
  Database get db => _db!;

  Future<void> initDatabase()async{
    print('INIT DATABASE');
    _db = await openDatabase('database.db',version: 1,onCreate: (db, version)async{
      try{
        await db.execute('''
          CREATE TABLE IF NOT EXISTS entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            title TEXT,
            description TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS images (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            entry_id INTEGER NOT NULL,
            image BLOB,
            FOREIGN KEY(ENTRY_id) REFERENCES entries(id)
          )
        ''');
        final List<Map<String, dynamic>> tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table";');
        print(tables);

        debugPrint('Table "activities" created successfully.');
      }catch(e){
        debugPrint('Error creating table: $e');
      }
      
    });
  }
}
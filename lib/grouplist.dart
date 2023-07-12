import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBBloodManager {
  late Database _datebase;

  Future openDB() async {
    _datebase = await openDatabase(
        join(await getDatabasesPath(), "Blood.db"),
        version: 1,
        onCreate: (Database db, int version) async
        {
          await db.execute("CREATE TABLE blood(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,bloodgroup TEXT)");
        }
    );
  }

  Future<int> insertBlood(Blood blood) async {
    await openDB();
    //the above line do nothing if the database is alredy exist, if there is no db it will create a db for you
    return await _datebase.insert('blood', blood.toMap());
  }

  Future<List<Blood>> getBloodList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('blood');
    return List.generate(maps.length, (index) {
      return Blood(id: maps[index]['id'], name: maps[index]['name'], bloodgroup: maps[index]['bloodgroup']);
    });
  }
  Future<int> updateBlood(Blood blood) async {
    await openDB();
    return await _datebase.update('blood', blood.toMap(), where: 'id=?', whereArgs: [blood.id]);
  }

  Future<void> deleteBlood(int? id) async {
    await openDB();
    await _datebase.delete("blood", where: "id = ? ", whereArgs: [id]);
  }
}


class Blood {
  int? id;
  String name;
  String bloodgroup;
  Blood({ this.id,required this.name, required this.bloodgroup});
  Map<String, dynamic> toMap() {
    return {'name': name, 'bloodgroup': bloodgroup};
  }
}
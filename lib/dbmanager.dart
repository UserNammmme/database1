import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBStudentManager {
  late Database _datebase;

  Future openDB() async {
    _datebase = await openDatabase(
                                    join(await getDatabasesPath(), "student.db"),
                                    version: 1,
                                     onCreate: (Database db, int version) async
                                     {
                                      await db.execute("CREATE TABLE student1(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,course TEXT)");
                                     }
                                     );
  }

  Future<int> insertStudent(Student student) async {
    await openDB();
    //the above line do nothing if the database is alredy exist, if there is no db it will create a db for you
    return await _datebase.insert('student1', student.toMap());
  }




  Future<List<Student>> getStudentList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('student1');
    return List.generate(maps.length, (index) {
      return Student(id: maps[index]['id'], name: maps[index]['name'], course: maps[index]['course']);
    });
  }
  Future<int> updateStudent(Student student) async {
    await openDB();
    return await _datebase.update('student1', student.toMap(), where: 'id=?', whereArgs: [student.id]);
  }

  Future<void> deleteStudent(int? id) async {
    await openDB();
    await _datebase.delete("student1", where: "id = ? ", whereArgs: [id]);
  }
}


class Student {
  int? id;
  String name;
  String course;
  Student({ this.id,required this.name, required this.course});
  Map<String, dynamic> toMap() {
    return {'name': name, 'course': course};
  }
}
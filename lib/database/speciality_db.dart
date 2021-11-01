import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';
import 'package:flutter_back_php/services/speciality.dart';

class SpecialityDB {
  static Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path,"speciality.db"); //create path to database

    return await openDatabase( //open the database or create a database if there isn't any
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE Speciality(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nom TEXT,
          img TEXT)"""
          );
          await db.execute("""
          CREATE TABLE Speciality2(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nom TEXT,
          img TEXT)"""
          );
        });
  }

  Future<List<Speciality>> fetchSpecialities() async{ //returns the memos as a list (array)

    final db = await init();
    final List<Map<String, dynamic>> maps = await db.query("Speciality"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) { //create a list of memos
      return Speciality(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        img: maps[i]['img'],
      );
    });
  }

  Future<Speciality?> getSpeciality(String speciality) async {
    final db = await init();
    final List<Map<String, dynamic>> maps = await db.query("Speciality",
        where: 'nom = ?',
      whereArgs: [speciality]
    );
    if (maps.length > 0) {
      return Speciality.fromMap(maps.first);
    }
    return null;
  }


}
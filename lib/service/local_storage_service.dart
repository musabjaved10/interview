import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:question_one/model/photo.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageService {
  static Database? _database;
  static final db = LocalStorageService();

  LocalStorageService();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  // Create the database
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'photosDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Photo('
          'id INTEGER PRIMARY KEY,'
          'albumId INTEGER,'
          'title TEXT,'
          'url TEXT,'
          'thumbnailUrl TEXT'
          ')');
    });
  }

  // Insert Photos in database
  createPhoto(Photo photo) async {
    final db = await database;

    final res = await db.insert('Photo', photo.toJson());
    return res;
  }

  // remove all Photos
  Future<int> removeAllPhotos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Photo');

    return res;
  }

  Future<List<Photo>> getAllPhotos() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Photo");

    List<Photo> list = res.isNotEmpty
        ? res.map((value) => Photo.fromJson(value)).toList()
        : [];
    return list;
  }
}

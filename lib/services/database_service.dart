import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class DatabaseService {
  static final DatabaseService db = DatabaseService._();
  static Database? _db;
  DatabaseService._();

  Future<Database?> get getDatabase async {
    if (_db != null) return _db!;
    _db = await _initBD("phrases.db");
    return _db;
  }

  Future<Database?> _initBD(String dbName) async {
    try {
      io.Directory applicationDirectory =
          await getApplicationDocumentsDirectory();
      String dbPathName = path.join(applicationDirectory.path, dbName);
      await deleteDatabase(dbPathName);
      ByteData data = await rootBundle.load(path.join("assets", "db", dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await io.File(dbPathName).writeAsBytes(bytes, flush: true);
      _db = await openDatabase(dbPathName, version: 1);

      return _db;
    } catch (e) {
      return null;
    }
  }
}

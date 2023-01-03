import 'package:frases/models/phrase_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class FavoritesDatabase {
  static final FavoritesDatabase instance = FavoritesDatabase._init();
  static Database? _database;

  FavoritesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorite_phrases.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final pathName = path.join(dbPath, filePath);
    return await openDatabase(pathName, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'TEXT NOT NULL PRIMARY KEY';
    const stringType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE ${PhraseTable.tableName} (
  ${PhraseTable.id} $idType,
  ${PhraseTable.category} $stringType,  
  ${PhraseTable.status} $intType,  
  ${PhraseTable.img} $stringType,  
  ${PhraseTable.phrase} $stringType
)
''');
  }

  // Future closeDB() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}

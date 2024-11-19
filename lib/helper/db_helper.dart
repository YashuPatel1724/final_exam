import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? _database;

  Future<Database> get database async => _database ?? await initData();

  Future<Database> initData() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'contact.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
      CREATE TABLE contact(
      id INTEGER NOT NULL,
      name TEXT NOT NULL,
      phoneNo TEXT NOT NULL,
      email TEXT NOT NULL
      )
      ''';
        db.execute(sql);
      },
    );
  }

  Future<int> insertDataInDatabase(
      {required int id,
      required String name,
      required String phoneNo,
      required String email}) async {
    final db = await database;
    String sql = '''
    INSERT INTO contact(
    id, name, phoneNo, email 
    ) VALUES (?, ?, ?, ?)
    ''';
    List args = [id, name, phoneNo, email];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readData()
  async {
    final db = await database;
    String sql = '''
    SELECT * FROM contact
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateData({required int id,
    required String name,
    required String phoneNo,
    required String email})
  async {
    final db = await database;
    String sql = '''
    UPDATE contact SET name = ?, phoneNo = ?, email = ? WHERE id = ?
    ''';
    List args = [name, phoneNo, email, id];
    return await db.rawUpdate(sql, args);
  }
  Future<int> deleteData({required int id})
  async {
    final db = await database;
    String sql = '''
    DELETE FROM contact WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }

  Future<bool> dataLocallySave(int id)
  async {
    final db = await database;
    String sql = '''
    SELECT * FROM contact WHERE id = ? 
    ''';
    List contact = await db.rawQuery(sql, [id]);
    return contact.isNotEmpty;
  }

  Future<List<Map<String, Object?>>> searchName(String name)
  async {
    final db = await database;
    String sql = '''
    SELECT * FROM contact WHERE name LIKE '%$name%'
    ''';
    return await db.rawQuery(sql);
  }
}

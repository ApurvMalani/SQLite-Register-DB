import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:basic/user_model.dart';

class UsedataBaseProvider {
  UsedataBaseProvider._();

  static final UsedataBaseProvider db = UsedataBaseProvider._();

  Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    } else {
      _database = await getDataBaseInstance();
      return _database!;
    }
  }

  Future<Database> getDataBaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "user.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
           CREATE TABLE IF NOT EXISTS User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            password TEXT
            )
             """);
      },
    );
  }

  Future<List<User>> getAllData() async {
    final db = await getDatabase();
    var response = await db.query("User");
    List<User> list = response.map((c) => User.fromMap(c)).toList();
    return list;
  }

  Future<User?> getUserId(int id) async {
    final db = await getDatabase();
    var response = await db.query("User", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }

  //  Insert  user data  base
  Future<User> addUserDataBase(User user) async {
    final db = await getDatabase();
    var table = await db.rawQuery("select max(id)+1  as id from  user");
    int id = table.first["id"] != null ? table.first["id"] as int : 0;

    user.id = id;
    await db.insert(
      "User",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  //  Delete  user by id
  Future<int> deleteUserId(int id) async {
    final db = await getDatabase();
    return db.delete("User", where: "id = ?", whereArgs: [id]);
  }

  //  Delete all users
  Future<int> deleteAllUsers() async {
    final db = await getDatabase();
    return db.delete("User");
  }

  //Update
  Future<int> updateUser(User user) async {
    final  Database db = await getDatabase();
    return await db.update(
      "User",
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }
}



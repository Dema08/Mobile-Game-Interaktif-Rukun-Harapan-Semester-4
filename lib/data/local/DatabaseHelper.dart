import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 4, // Increment the version number
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await _refreshTables(db);
        }
      },
    );
  }

  Future<void> _createTables(Database db) async {}

  Future<void> _refreshTables(Database db) async {
    // await db.execute('DROP TABLE IF EXISTS provinces');
    // await db.execute('DROP TABLE IF EXISTS regencies');
    await _createTables(db);
  }
}

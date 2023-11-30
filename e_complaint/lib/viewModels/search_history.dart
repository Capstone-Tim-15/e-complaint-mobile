import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SearchHistoryDatabase {
  static final SearchHistoryDatabase instance = SearchHistoryDatabase._init();

  static Database? _database;
  SearchHistoryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'search_history.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
       CREATE TABLE search_history (
         id INTEGER PRIMARY KEY,
         query TEXT NOT NULL
       )
     ''');
    });
  }

  Future<void> addToHistory(String query) async {
    final db = await instance.database;
    await db.insert('search_history', {'query': query});
  }

  Future<List<String>> getHistory() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('search_history');
    return List.generate(maps.length, (i) {
      return maps[i]['query'];
    });
  }
}

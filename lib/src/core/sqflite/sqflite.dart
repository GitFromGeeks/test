import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  static SqfliteService? _instance;
  static SqfliteService get instance => _instance ??= SqfliteService();

  static Database? db;

  Future<Database> get database async => db ?? await init();

  Future<Database> init() async {
    final osPath = await getDatabasesPath();
    final path = join(osPath, 'test_post.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT)',
        );
      },
    );
  }

  Future<void> insertAll(String table, List<Map<String, Object?>> data) async {
    final dbClient = await database;
    final batch = dbClient.batch();
    for (var item in data) {
      batch.insert(table, item);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, Object?>>> getAll(String table) async {
    final dbClient = await database;
    return await dbClient.query(table);
  }
}

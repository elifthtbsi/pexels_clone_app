import 'package:path/path.dart';
import 'package:pexels_clone_app/JsonModels/users.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class DatabaseHelper {
  final databaseName = "notes.db";
  String noteTable =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  //Now we must create our user table into our sqlite db

  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  //We are done in this section

  Future<bool> isUserExists(String username) async {
    final Database db = await initDB();
    final result = await db.query(
      'users',
      where: 'usrName = ?',
      whereArgs: [username],
    );

    return result.isNotEmpty;
  }

  Future<Database> initDB() async {
    databaseFactory = databaseFactoryFfi;
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(noteTable);
    });
  }

  //Now we create login and sign up method
  //as we create sqlite other functionality in our previous video

  //IF you didn't watch my previous videos, check part 1 and part 2

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }
}

class FavoriDatabase {
  late Database _db;

  // Veritabanına bağlanma işlemi
  Future<void> connect() async {
    _db = await openDatabase(
      'favori_database.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // Favori tablosunu oluştur
        await db.execute('''
          CREATE TABLE favori_tablo (
            id INTEGER PRIMARY KEY,
            kullanici_id INTEGER,
            fotograf_id INTEGER
          )
        ''');
      },
    );
  }

  // Favori ekleme işlemi
  Future<void> addToFavorites(int kullaniciID, int fotografID) async {
    await _db.insert('favori_tablo', {'kullanici_id': kullaniciID, 'fotograf_id': fotografID});
  }

  // Kullanıcının favori fotoğraflarını getirme işlemi
  Future<List<Map<String, dynamic>>> getFavoritePhotos(int kullaniciID) async {
    return await _db.query('favori_tablo', where: 'kullanici_id = ?', whereArgs: [kullaniciID]);
  }
}

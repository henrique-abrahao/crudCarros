import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:trampoely2/modal/modals_car.dart';

class DBCars {
  static final DBCars _instance = DBCars.internal();

  factory DBCars() => _instance;

  DBCars.internal();

  Database _db;

  Future<Database> get db async{
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cars.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute("CREATE TABLE cars("
          "id INTEGER PRIMARY KEY,"
          "nome TEXT, "
          "imagem TEXT, "
          "ano TEXT, "
          "modelo TEXT,"
          "cor TEXT,"
          "combustivel TEXT)" );
        });
  }

  Future<Cars> saveCar(Cars cars) async{
    Database dbCars = await db;
    cars.id = await dbCars.insert('cars', cars.toMap());
    return cars;
  }

  Future<Cars> getCar(int id) async{
    Database dbCars = await db;
    List<Map> maps = await dbCars.query('cars',
        columns: ['id', 'nome', 'imagem', 'ano', 'modelo', 'cor', 'combustivel'],
        where: "id = ?",
        whereArgs: [id]);
    if(maps.length > 0 ){
      return Cars.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> deleteCar(int id) async{
    Database dbCars = await db;
    return await dbCars.delete('cars', where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateCar(Cars cars) async {
    Database dbCars = await db;
    return await dbCars.update('cars', cars.toMap(), where: "id = ?", whereArgs: [cars.id]);
  }

  Future<List> getAllCar() async{
    Database dbCars = await db;
    List listMap = await dbCars.rawQuery("SELECT * FROM cars");
    List<Cars> listContact = List();
    for(Map m in listMap){
      listContact.add(Cars.fromMap(m));
    }
    return listContact;
  }


  Future close()async{
    Database dbCars = await db;
    dbCars.close();
  }
}
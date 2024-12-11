import 'package:data_management/data/models/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataServices {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'informacion.db'),
      onCreate: (db, version) => db.execute('''
      CREATE TABLE datos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      descripcion TEXT,
      precio INTEGER,
      existencia INTEGER,
      porcentajeDescuento INTEGER,
      valoracion INTEGER,
      marca TEXT,
      modelo TEXT,
      formaIngreso TEXT,
      categoria TEXT,
      ultimoIngreso TEXT,
      activo INTEGER,
      imagen TEXT
      )
      '''),
      version: 1,
    );
  }

  Future<void> insert(DataModel dato) async {
    Database db = await getDatabase();
    await db.insert('datos', dato.toMap());
  }

  Future<List<DataModel>> getAll() async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> mapsDatos = await db.query('datos');

    mapsDatos.forEach((dato) {
      print("obteniendo datos.. ${dato['id']}");
    });

    return List.generate(mapsDatos.length, (index) {
      return DataModel.fromMap(mapsDatos[index]);
    });
  }

  Future<void> update(DataModel dato) async {
    Database db = await getDatabase();
    await db
        .update('datos', dato.toMap(), where: 'id = ?', whereArgs: [dato.id]);
  }

  Future<void> delete(int? id) async {
    Database db = await getDatabase();
    await db.delete('datos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteALL() async {
    Database db = await getDatabase();
    await db.delete('datos');
  }
}

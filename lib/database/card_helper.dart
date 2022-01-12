import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String cardsTable = "cardsTable";
const String idColumn = "idColumn";
const String backColumn = "backColumn";
const String frontColumn = "frontColumn";
const String dataInclusaoColumn = "dataInclusaoColumn";
const String qtdRevisaoColumn = "qtdRevisaoColumn";
const String proxRevisaoColumn = "proxRevisaoColumn";

class CardHelper {
  static final CardHelper _instance = CardHelper.internal();

  factory CardHelper() => _instance;

  CardHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    // ignore: unnecessary_null_comparison
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'cards.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          'CREATE TABLE $cardsTable ($idColumn INTEGER PRIMARY KEY, $backColumn TEXT, $frontColumn TEXT, $dataInclusaoColumn TEXT, $qtdRevisaoColumn TEXT, $proxRevisaoColumn TEXT)');
    });
  }

  Future<Cartao> adicionarCartao(Cartao cartao) async {
    Database? dbCartao = await db;
    cartao.id = await dbCartao!.insert(cardsTable, cartao.toMap());
    return cartao;
  }

  Future<Cartao?> getCartao(int id) async {
    Database? dbCartao = await db;
    List<Map> maps = await dbCartao!.query(cardsTable,
        columns: [
          idColumn,
          backColumn,
          frontColumn,
          dataInclusaoColumn,
          qtdRevisaoColumn,
          proxRevisaoColumn
        ],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Cartao.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCartao(int id) async {
    Database? dbCartao = await db;
    return await dbCartao!
        .delete(cardsTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateCartao(Cartao cartao) async {
    Database? dbCartao = await db;
    return await dbCartao!.update(cardsTable, cartao.toMap(),
        where: '$idColumn = ?', whereArgs: [cartao.id]);
  }

  Future<List> getAllCards() async {
    Database? dbCartao = await db;
    List listMap = await dbCartao!.rawQuery('SELECT * FROM $cardsTable');
    List<Cartao> listCartao = [];
    for (Map m in listMap) {
      listCartao.add(Cartao.fromMap(m));
    }
    return listCartao;
  }

  close() async {
    Database? dbCartao = await db;
    await dbCartao!.close();
  }
}

class Cartao {
  int? id;
  String? back;
  String? front;
  String? dataInclusao;
  int? qtdRevisao;
  String? proxRevisao;

  Cartao();

  Cartao.fromMap(Map map) {
    id = map['idColumn'];
    back = map['backColumn'];
    front = map['frontColumn'];
    dataInclusao = map['dataInclusaoColumn'];
    qtdRevisao = int.parse((map['qtdRevisaoColumn']));
    proxRevisao = map['proxRevisaoColumn'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'backColumn': back,
      'frontColumn': front,
      'dataInclusaoColumn': dataInclusao,
      'qtdRevisaoColumn': qtdRevisao,
      'proxRevisaoColumn': proxRevisao
    };
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map['idColumn'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Cartao(id: $id, back: $back, front: $front, dataInclusao: $dataInclusao, qtdRevisao: $qtdRevisao, proxRevisao: $proxRevisao)';
  }
}
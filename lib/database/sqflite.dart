import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//atributos da tabela cards
const String cardsTable = "cardsTable";
const String idColumn = "idColumn";
const String isImageColumn = "isImageColumn";
const String backColumn = "backColumn";
const String frontColumn = "frontColumn";
const String frontImageColumn = "frontImageColumn";
const String backImageColumn = "backImageColumn";
const String nivelColumn = "nivelColumn";
const String proxRevisaoColumn = "proxRevisaoColumn";
const String fkDeckColumn = "fkDeckColumn";

//atributos da tabela decks
const String decksTable = 'decksTable';
const String idDeckColumn = 'idDeckColumn';
const String nameDeckColumn = 'nameDeckColumn';

class SQFlite {
  static final SQFlite _instance = SQFlite.internal();

  factory SQFlite() => _instance;

  SQFlite.internal();

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
    final path = join(databasesPath, 'anki.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          'CREATE TABLE $cardsTable ($idColumn INTEGER PRIMARY KEY autoincrement, $isImageColumn INTEGER, $backColumn TEXT, $frontColumn TEXT, $backImageColumn BLOB, $frontImageColumn BLOB, $nivelColumn INTEGER, $proxRevisaoColumn TEXT, $fkDeckColumn INTEGER)');

      await db.execute(
          'CREATE TABLE $decksTable ($idDeckColumn INTEGER PRIMARY KEY autoincrement, $nameDeckColumn TEXT)');
    });
  }

  Future<Cartao> adicionarCartao(Cartao cartao) async {
    Database? dbCartao = await db;
    cartao.id = await dbCartao!.insert(cardsTable, cartao.toMap());
    return cartao;
  }

  Future<Deck> adicionarDeck(Deck deck) async {
    Database? dbDeck = await db;
    deck.idDeck = await dbDeck!.insert(decksTable, deck.toMap());
    return deck;
  }

  Future<Cartao?> getCartao(int id) async {
    Database? dbCartao = await db;
    List<Map> maps = await dbCartao!.query(cardsTable,
        columns: [
          idColumn,
          isImageColumn,
          backColumn,
          frontColumn,
          backImageColumn,
          frontImageColumn,
          nivelColumn,
          proxRevisaoColumn,
          fkDeckColumn
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

  Future<List> getAllCardsToStudy(idDeck) async {
    DateTime hoje = DateTime.now();
    //print(hoje);
    Database? dbCartao = await db;
    List listMap = await dbCartao!
        .rawQuery('SELECT * FROM $cardsTable WHERE $fkDeckColumn = $idDeck');
    List<Cartao> listCartao = [];
    for (Map m in listMap) {
      DateTime proxRev = DateTime.parse(m['proxRevisaoColumn']);
      if (proxRev.isBefore(hoje)) {
        listCartao.add(Cartao.fromMap(m));
      }
    }
    return listCartao;
  }

  Future<List> getAllCardsForDeck(idDeck) async {
    Database? dbCartao = await db;
    List listMap = await dbCartao!
        .rawQuery('SELECT * FROM $cardsTable WHERE $fkDeckColumn = $idDeck');
    List<Cartao> listCartao = [];
    for (Map m in listMap) {
      listCartao.add(Cartao.fromMap(m));
    }
    return listCartao;
  }

  Future<List> getAllDecks() async {
    Database? dbDeck = await db;
    List listMap = await dbDeck!.rawQuery('SELECT * FROM $decksTable');
    //List listMap = await dbDeck!.rawQuery('SELECT * FROM $cardsTable as c INNER JOIN $decksTable as d on c.$fkDeckColumn = d.$idDeckColumn');
    List<Deck> listDeck = [];
    for (Map m in listMap) {
      listDeck.add(Deck.fromMap(m));
    }
    return listDeck;
  }

  close() async {
    Database? dbCartao = await db;
    await dbCartao!.close();
  }
}

class Cartao {
  int? id;
  int? isImage;
  String? back;
  String? front;
  Uint8List? frontImage;
  Uint8List? backImage;
  int? nivel;
  String? proxRevisao;
  int? fkDeck;

  Cartao();

  Cartao.fromMap(Map map) {
    id = map[idColumn];
    isImage = map[isImageColumn];
    back = map[backColumn];
    front = map[frontColumn];
    frontImage = map[frontImageColumn];
    backImage = map[backImageColumn];
    nivel = map[nivelColumn];
    proxRevisao = map[proxRevisaoColumn];
    fkDeck = map[fkDeckColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      isImageColumn: isImage,
      backColumn: back,
      frontColumn: front,
      backImageColumn: backImage,
      frontImageColumn: frontImage,
      nivelColumn: nivel,
      proxRevisaoColumn: proxRevisao,
      fkDeckColumn: fkDeck
    };
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Cartao(id: $id, isImage: $isImage, back: $back, front: $front, backImage: $backImage, frontImage: $frontImage, nivel: $nivel, proxRevisao: $proxRevisao, fkDeck: $fkDeck)';
  }
}

class Deck {
  int? idDeck;
  String? nameDeck;

  Deck();

  Deck.fromMap(Map map) {
    idDeck = map[idDeckColumn];
    nameDeck = map[nameDeckColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameDeckColumn: nameDeck,
    };
    // ignore: unnecessary_null_comparison
    if (idDeck != null) {
      map[idDeckColumn] = idDeck;
    }
    return map;
  }

  @override
  String toString() {
    return 'Deck(idDeck: $idDeck, nameDeck: $nameDeck)';
  }
}

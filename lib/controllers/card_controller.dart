import 'package:anki_clone/database/sqflite.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  List cards = [].obs;

  SQFlite sqFlite = SQFlite();

  getCards(idDeck) async{
    cards = await sqFlite.getAllCardsToStudy(idDeck);
    update();
  }

  addCards(cartao) {
    sqFlite.adicionarCartao(cartao);
    update();
  }
}

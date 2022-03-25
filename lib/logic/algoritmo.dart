import 'package:anki_clone/database/sqflite.dart';

class Algoritmo {
  SQFlite sqFlite = SQFlite();

  botaoDificil(cartao) {
    DateTime hoje = DateTime.now();
    DateTime? proxRevisao;
    int novoNivel = 0;

    switch (cartao.nivel) {
      case 0:
        {
          proxRevisao = hoje;
          novoNivel = 0;
        }
        break;

      case 1:
        {
          proxRevisao = hoje;
          novoNivel = 0;
        }
        break;

      case 2:
        {
          proxRevisao = hoje.add(const Duration(days: 2));
          novoNivel = 1;
        }
        break;

      case 3:
        {
          proxRevisao = hoje.add(const Duration(days: 4));
          novoNivel = 2;
        }
        break;

      case 4:
        {
          proxRevisao = hoje.add(const Duration(days: 8));
          novoNivel = 3;
        }
        break;

      case 5:
        {
          proxRevisao = hoje.add(const Duration(days: 22));
          novoNivel = 4;
        }
        break;

      case 6:
        {
          proxRevisao = hoje.add(const Duration(days: 44));
          novoNivel = 5;
        }
        break;

      default:
        {
          // ignore: avoid_print
          print("sem nivel");
        }
        break;
    }

    Cartao c = Cartao();
    c.id = cartao.id;
    c.isImage = cartao.isImage;
    c.back = cartao.back;
    c.front = cartao.front;
    c.backImage = cartao.backImage;
    c.frontImage = cartao.frontImage;
    c.nivel = novoNivel;
    c.proxRevisao = proxRevisao.toString();
    c.fkDeck = cartao.fkDeck;
    sqFlite.updateCartao(c);
  }

  botaoBom(cartao) {
    DateTime hoje = DateTime.now();
    DateTime? proxRevisao;
    int novoNivel = 0;

    switch (cartao.nivel) {
      case 0:
        {
          proxRevisao = hoje;
          novoNivel = 1;
        }
        break;

      case 1:
        {
          proxRevisao = hoje.add(const Duration(days: 1));
          novoNivel = 2;
        }
        break;

      case 2:
        {
          proxRevisao = hoje.add(const Duration(days: 3));
          novoNivel = 3;
        }
        break;

      case 3:
        {
          proxRevisao = hoje.add(const Duration(days: 7));
          novoNivel = 4;
        }
        break;

      case 4:
        {
          proxRevisao = hoje.add(const Duration(days: 17));
          novoNivel = 5;
        }
        break;

      case 5:
        {
          proxRevisao = hoje.add(const Duration(days: 45));
          novoNivel = 6;
        }
        break;

      case 6:
        {
          proxRevisao = hoje.add(const Duration(days: 96));
          novoNivel = 6;
        }
        break;

      default:
        {
          // ignore: avoid_print
          print("sem nivel");
        }
        break;
    }

    Cartao c = Cartao();
    c.id = cartao.id;
    c.isImage = cartao.isImage;
    c.back = cartao.back;
    c.front = cartao.front;
    c.backImage = cartao.backImage;
    c.frontImage = cartao.frontImage;
    c.nivel = novoNivel;
    c.fkDeck = cartao.fkDeck;
    c.proxRevisao = proxRevisao.toString();
    sqFlite.updateCartao(c);
  }

  botaoFacil(cartao) {
    DateTime hoje = DateTime.now();
    DateTime? proxRevisao;
    int novoNivel = 0;

    switch (cartao.nivel) {
      case 0:
        {
          proxRevisao = hoje.add(const Duration(days: 1));
          novoNivel = 2;
        }
        break;

      case 1:
        {
          proxRevisao = hoje.add(const Duration(days: 4));
          novoNivel = 3;
        }
        break;

      case 2:
        {
          proxRevisao = hoje.add(const Duration(days: 4));
          novoNivel = 5;
        }
        break;

      case 3:
        {
          proxRevisao = hoje.add(const Duration(days: 13));
          novoNivel = 6;
        }
        break;

      case 4:
        {
          proxRevisao = hoje.add(const Duration(days: 22));
          novoNivel = 6;
        }
        break;

      case 5:
        {
          proxRevisao = hoje.add(const Duration(days: 60));
          novoNivel = 6;
        }
        break;

      case 6:
        {
          proxRevisao = hoje.add(const Duration(days: 130));
          novoNivel = 6;
        }
        break;

      default:
        {
          // ignore: avoid_print
          print("sem nivel");
        }
        break;
    }

    Cartao c = Cartao();
    c.id = cartao.id;
    c.isImage = cartao.isImage;
    c.back = cartao.back;
    c.front = cartao.front;
    c.backImage = cartao.backImage;
    c.frontImage = cartao.frontImage;
    c.nivel = novoNivel;
    c.fkDeck = cartao.fkDeck;
    c.proxRevisao = proxRevisao.toString();
    sqFlite.updateCartao(c);
  }
}

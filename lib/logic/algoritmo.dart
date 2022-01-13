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
          proxRevisao = hoje.add(const Duration(days: 1));
          novoNivel = 0;
        }
        break;

      case 2:
        {
          proxRevisao = hoje.add(const Duration(days: 4));
          novoNivel = 1;
        }
        break;

      case 3:
        {
          proxRevisao = hoje.add(const Duration(days: 8));
          novoNivel = 2;
        }
        break;

      case 4:
        {
          proxRevisao = hoje.add(const Duration(days: 16));
          novoNivel = 3;
        }
        break;

      case 5:
        {
          proxRevisao = hoje.add(const Duration(days: 32));
          novoNivel = 4;
        }
        break;

      case 6:
        {
          proxRevisao = hoje.add(const Duration(days: 64));
          novoNivel = 5;
        }
        break;

      default:
        {
          print("sem nivel");
        }
        break;
    }

    Cartao c = Cartao();
    c.id = cartao.id;
    c.back = cartao.back;
    c.front = cartao.front;
    c.nivel = novoNivel;
    c.proxRevisao = proxRevisao.toString();
    sqFlite.updateCartao(c);
  }

  botaoBom(cartao) {
    DateTime hoje = DateTime.now();
    DateTime? proxRevisao;
    int novoNivel = 0;

    switch (cartao.nivel) {
      case 0:
        {
          proxRevisao = hoje.add(const Duration(days: 1));
          novoNivel = 1;
        }
        break;

      case 1:
        {
          proxRevisao = hoje.add(const Duration(days: 4));
          novoNivel = 2;
        }
        break;

      case 2:
        {
          proxRevisao = hoje.add(const Duration(days: 8));
          novoNivel = 3;
        }
        break;

      case 3:
        {
          proxRevisao = hoje.add(const Duration(days: 16));
          novoNivel = 4;
        }
        break;

      case 4:
        {
          proxRevisao = hoje.add(const Duration(days: 32));
          novoNivel = 5;
        }
        break;

      case 5:
        {
          proxRevisao = hoje.add(const Duration(days: 64));
          novoNivel = 6;
        }
        break;

      case 6:
        {
          proxRevisao = hoje.add(const Duration(days: 128));
          novoNivel = 6;
        }
        break;

      default:
        {
          print("sem nivel");
        }
        break;
    }

    Cartao c = Cartao();
    c.id = cartao.id;
    c.back = cartao.back;
    c.front = cartao.front;
    c.nivel = novoNivel;
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
          proxRevisao = hoje.add(const Duration(days: 8));
          novoNivel = 5;
        }
        break;

      case 3:
        {
          proxRevisao = hoje.add(const Duration(days: 16));
          novoNivel = 6;
        }
        break;

      case 4:
        {
          proxRevisao = hoje.add(const Duration(days: 32));
          novoNivel = 6;
        }
        break;

      case 5:
        {
          proxRevisao = hoje.add(const Duration(days: 64));
          novoNivel = 6;
        }
        break;

      case 6:
        {
          proxRevisao = hoje.add(const Duration(days: 128));
          novoNivel = 6;
        }
        break;

      default:
        {
          print("sem nivel");
        }
        break;
    }

    Cartao c = Cartao();
    c.id = cartao.id;
    c.back = cartao.back;
    c.front = cartao.front;
    c.nivel = novoNivel;
    c.proxRevisao = proxRevisao.toString();
    sqFlite.updateCartao(c);
  }
}

import 'package:anki_clone/logic/algoritmo.dart';
import 'package:anki_clone/views/addcard.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:anki_clone/views/info_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  SQFlite helper = SQFlite();
  bool cartaVirada = false;
  bool temCartoes = true;
  bool finished = false;
  int qtdCartoes = 0;
  int count = 0;
  // ignore: prefer_typing_uninitialized_variables
  var cartaoSel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Anki Clone'),
          centerTitle: true,
        ),
        body: FutureBuilder<List>(
            future: helper.getAllCards(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                temCartoes = false;
                return const Center(child: Text('Não há cartões para estudar'));
              } else {
                temCartoes = true;
                qtdCartoes = snapshot.data!.length;
                cartaoSel = snapshot.data![count];
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              FlipCard(
                                speed: 230,
                                fill: Fill.fillFront,
                                direction: FlipDirection.VERTICAL,
                                key: cardKey,
                                flipOnTouch: false,
                                front: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8)),
                                    width: width,
                                    height: width / 2,
                                    child: Center(
                                      child: Text(snapshot.data![count].front,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    )),
                                back: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(8)),
                                    width: width,
                                    height: width / 2,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(snapshot.data![count].front,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          const Divider(
                                            height: 20,
                                            thickness: 1,
                                          ),
                                          Text(snapshot.data![count].back,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                    cartaVirada
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextButton(
                                    onPressed: () {
                                      Algoritmo().botaoDificil(
                                        cartaoSel,
                                      );
                                      nextCard();
                                    },
                                    child: const Text(
                                      'Difícil',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextButton(
                                    onPressed: () {
                                      Algoritmo().botaoBom(
                                        cartaoSel,
                                      );
                                      nextCard();
                                    },
                                    child: const Text(
                                      'Bom',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextButton(
                                    onPressed: () {
                                      Algoritmo().botaoFacil(
                                        cartaoSel,
                                      );
                                      nextCard();
                                    },
                                    child: const Text(
                                      'Fácil',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.grey[700],
                                  child: TextButton(
                                      onPressed: () {
                                        cardKey.currentState!.toggleCard();
                                        setState(() {
                                          cartaVirada = true;
                                        });
                                      },
                                      child: const Text('Mostrar resposta',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))),
                                ),
                              ),
                            ],
                          )
                  ],
                );
              }
            }));
  }

  nextCard() {
    print(count);
    print(qtdCartoes);
    if (count < qtdCartoes) {
      cardKey.currentState!.toggleCard();
      setState(() {
        cartaVirada = false;
      });
      count++;
    } else {
      print('acabou os cartões');
    }
  }
}

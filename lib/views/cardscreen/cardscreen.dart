import 'package:anki_clone/logic/algoritmo.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:anki_clone/views/cardscreen/botao_escolha.dart';
import 'package:anki_clone/views/cardscreen/botao_mostrar.dart';
import 'package:anki_clone/views/cardscreen/card_image.dart';
import 'package:anki_clone/views/cardscreen/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const CardScreen(this.snapshot, {Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  FlipCardController? _controller;

  PageController? _pageController;
  SQFlite helper = SQFlite();
  bool cartaVirada = false;
  // ignore: prefer_typing_uninitialized_variables
  var cartaoSel;

  @override
  void initState() {
    _controller = FlipCardController();
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.snapshot.nameDeck),
          centerTitle: true,
        ),
        body: FutureBuilder<List>(
            future: helper.getAllCardsToStudy(widget.snapshot.idDeck),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text('Ótimo trabalho!', style: TextStyle(fontSize: 18, color: Colors.blue),));
              } else {
                return PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, i) {
                      cartaoSel = snapshot.data![i];
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    child: snapshot.data![i].isImage == 1 ? CardImage(cartaVirada, snapshot.data![i])
                                    : FlipCardCustom(
                                        _controller, snapshot.data![i])),
                              ],
                            ),
                          ),
                          cartaVirada
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BotaoEscolha('Difícl', Colors.red, () {
                                      Algoritmo().botaoDificil(
                                        cartaoSel,
                                      );
                                      nextCard();
                                    }),
                                    BotaoEscolha('Bom', Colors.green, () {
                                      Algoritmo().botaoBom(
                                        cartaoSel,
                                      );
                                      nextCard();
                                    }),
                                    BotaoEscolha('Fácil', Colors.blue, () {
                                      Algoritmo().botaoFacil(
                                        cartaoSel,
                                      );
                                      nextCard();
                                    }),
                                  ],
                                )
                              : BotaoMostrar(() {
                                  _controller!.toggleCard();
                                  setState(() {
                                    cartaVirada = true;
                                  });
                                })
                        ],
                      );
                    });
              }
            }));
  }

  nextCard() {
    _pageController!.nextPage(
        duration: const Duration(milliseconds: 1), curve: Curves.fastOutSlowIn);
    _controller!.toggleCard();
    setState(() {
      cartaVirada = false;
    });
  }
}

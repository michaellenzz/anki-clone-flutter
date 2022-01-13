import 'package:anki_clone/logic/algoritmo.dart';
import 'package:anki_clone/views/addcard.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  SQFlite helper = SQFlite();
  bool visualized = false;
  bool finished = true;
  int qtdCartoes = 0;
  int count = 0;
  var cartaoSel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Anki Clone'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AddCard()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(8),
            child: finished
                ? FutureBuilder<List>(
                    future: helper.getAllCards(),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('Não há cartões para estudar'),
                        );
                      } else {
                        qtdCartoes = snapshot.data!.length;
                        cartaoSel = snapshot.data![count];
                        finished = true;
                        return Column(
                          children: [
                            Text(
                              snapshot.data![count].front,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            visualized ? const Divider() : Container(),
                            visualized
                                ? Text(
                                    snapshot.data![count].back,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Container()
                          ],
                        );
                      }
                    })
                : const Center(
                    child: Text(
                      'Parabéns! você terminou todos os cartões.',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
        bottomSheet: visualized
            ? finished
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        
                        child: TextButton(
                            onPressed: () {
                              Algoritmo().botaoDificil(
                                cartaoSel,
                              );
                              nextCard();
                            },
                            child: const Text(
                              'Difícil',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: TextButton(
                            onPressed: () {
                              Algoritmo().botaoBom(
                                cartaoSel,
                              );
                              nextCard();
                            },
                            child: const Text(
                              'Bom',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: TextButton(
                            onPressed: () {
                              Algoritmo().botaoFacil(
                                cartaoSel,
                              );
                              nextCard();
                            },
                            child: const Text(
                              'Fácil',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                    ],
                  )
                : Container(
                    height: 0,
                  )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey[700],
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              visualized = true;
                            });
                          },
                          child: const Text('Mostrar resposta',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))),
                    ),
                  ),
                ],
              ));
  }

  nextCard() {
    setState(() {
      if (count < qtdCartoes - 1) {
        count++;
        visualized = false;
      } else {
        finished = false;
      }
    });
  }
}

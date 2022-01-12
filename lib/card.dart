import 'package:anki_clone/addcard.dart';
import 'package:anki_clone/database/card_helper.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CardHelper helper = CardHelper();
  bool visualized = false;
  bool finished = true;
  int qtdCartoes = 0;
  int count = 0;

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
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('Não há cartões para estudar'),
                        );
                      } else {
                        qtdCartoes = snapshot.data!.length;
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
            ? finished ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    child: TextButton(
                        onPressed: () {
                          nextCard();
                        },
                        child: const Text(
                          'Novamente',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                  Container(
                    color: Colors.grey,
                    child: TextButton(
                        onPressed: () {
                          nextCard();
                        },
                        child: const Text(
                          ' Difícil ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                  Container(
                    color: Colors.green,
                    child: TextButton(
                        onPressed: () {
                          nextCard();
                        },
                        child: const Text(
                          '  Bom  ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                  Container(
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () {
                          nextCard();
                        },
                        child: const Text(
                          ' Fácil ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                ],
              ) : Container(height: 0,)
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

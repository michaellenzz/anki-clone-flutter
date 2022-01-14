import 'package:anki_clone/controllers/card_controller.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const AddCard(this.snapshot, {Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  SQFlite helper = SQFlite();

  var front = TextEditingController();
  var back = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshot.nameDeck),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Frente',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: front,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
            ),
            const Divider(),
            const Text(
              'Verso',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: back,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.blue),
              child: TextButton(
                child: const Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  CardController cc = Get.put(CardController());
                  if (back.text.isNotEmpty && front.text.isNotEmpty) {
                    Cartao c = Cartao();
                    c.back = back.text;
                    c.front = front.text;
                    c.proxRevisao = DateTime.now().toString();
                    c.nivel = 0;
                    c.fkDeck = widget.snapshot.idDeck;

                    cc.addCards(c);
                    back.clear();
                    front.clear();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:anki_clone/database/sqflite.dart';
import 'package:flutter/material.dart';

class AddDeck extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  const AddDeck({Key? key}) : super(key: key);

  @override
  _AddDeckState createState() => _AddDeckState();
}

class _AddDeckState extends State<AddDeck> {
  SQFlite helper = SQFlite();

  var name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar novo Baralho'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: name,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: 'Ex: Frases em inglês',
                  labelText: 'Nome do Baralho',
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
                  if (name.text.isNotEmpty) {
                    Deck d = Deck();
                    d.nameDeck = name.text;
                    helper.adicionarDeck(d);
                    name.clear();
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

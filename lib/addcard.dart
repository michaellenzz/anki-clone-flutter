import 'package:anki_clone/database/card_helper.dart';
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  CardHelper helper = CardHelper();

  var front = TextEditingController();
  var back = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck nome'),
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
              'Atrás',
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
                  Cartao c = Cartao();
                  c.back = back.text;
                  c.front = front.text;
                  c.dataInclusao = DateTime.now().toString();
                  c.proxRevisao = 'new';
                  c.qtdRevisao = 0;

                  helper.adicionarCartao(c);
                  back.clear();
                  front.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

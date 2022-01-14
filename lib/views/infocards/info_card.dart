import 'package:anki_clone/database/sqflite.dart';
import 'package:anki_clone/views/addcards/add_card.dart';
import 'package:anki_clone/views/cardscreen/cardscreen.dart';
import 'package:anki_clone/views/listcads/list_cards.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const InfoCard(this.snapshot, {Key? key}) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  SQFlite sqFlite = SQFlite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshot.nameDeck),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListCards(widget.snapshot)));
              },
              icon: const Icon(Icons.list)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddCard(widget.snapshot)));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder<List>(
          future: sqFlite.getAllCardsToStudy(widget.snapshot.idDeck),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                'Não há cartões para estudar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Você tem ${snapshot.data!.length} para estudar.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[400],
                    ),
                    child: TextButton(
                      child: const Text(
                        'Estudar',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardScreen(widget.snapshot)));
                      },
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}

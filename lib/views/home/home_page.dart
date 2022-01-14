import 'package:anki_clone/database/sqflite.dart';
import 'package:anki_clone/views/infocards/info_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SQFlite sqFlite = SQFlite();

  @override
  void initState() {
    //Deck d = Deck();
    //d.nameDeck = 'Primeiro Deck';
    //sqFlite.adicionarDeck(d);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anki Clone'),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
          future: sqFlite.getAllDecks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Não há Baralhos aqui.'));
            } else {
              return Container(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InfoCard(snapshot.data![0])));
                        },
                        child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300]),
                            child: Text(
                              snapshot.data![0].nameDeck,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                      );
                    }),
              );
            }
          }),
    );
  }
}

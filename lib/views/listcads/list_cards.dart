import 'package:anki_clone/database/sqflite.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListCards extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  ListCards(this.snapshot, {Key? key}) : super(key: key);
  SQFlite sqFlite = SQFlite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(snapshot.nameDeck),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
          future: sqFlite.getAllCardsForDeck(snapshot.idDeck),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Não há nenhum cartão aqui.'));
            } else {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (c, i) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[300]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    snapshot.data![i].front,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  Text(
                                    snapshot.data![i].back,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Quantidade de Cartões: ${snapshot.data!.length}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}

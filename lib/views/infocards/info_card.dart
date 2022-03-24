import 'package:anki_clone/controllers/card_controller.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:anki_clone/views/addcards/add_card.dart';
import 'package:anki_clone/views/addcards/add_card_image.dart';
import 'package:anki_clone/views/cardscreen/cardscreen.dart';
import 'package:anki_clone/views/listcads/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class InfoCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const InfoCard(this.snapshot, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<InfoCard> createState() => _InfoCardState(snapshot);
}

class _InfoCardState extends State<InfoCard> {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  _InfoCardState(this.snap) {
    if (snap != null) {
      cc.getCards(snap.idDeck);
    }
  }

  SQFlite sqFlite = SQFlite();

  CardController cc = Get.put(CardController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          tooltip: 'Adicionar novo card',
          // backgroundColor: Colors.white,
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
          isOpenOnStart: false,
          animationSpeed: 200,

          children: [
            SpeedDialChild(
              child: const Icon(Icons.photo),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Adicionar card com foto',
              onTap: () {
                Get.off(() => AddCardImage(widget.snapshot));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.text_fields_rounded),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              label: 'Adicionar card com texto',
              onTap: () {
                Get.off(() => AddCard(widget.snapshot));
              },
            ),
          ],
        ),
      appBar: AppBar(
        title: Text(widget.snapshot.nameDeck),
        centerTitle: true,
        actions: [
          
          IconButton(
              onPressed: () {
                Get.to(() => ListCards(widget.snapshot));
              },
              icon: const Icon(Icons.list)),
        ],
      ),
      body: GetBuilder<CardController>(builder: (value) {
        if (value.cards.isEmpty) {
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
                'Você tem ${value.cards.length} para estudar.',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                    setState(() {
                      //atualizar lista
                    });
                    Navigator.pushReplacement(
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

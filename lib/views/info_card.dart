import 'package:anki_clone/views/addcard.dart';
import 'package:anki_clone/views/cardscreen.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do Baralho'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Não há nenhuma carta para estudar',
          textAlign: TextAlign.center,),
          TextButton(child: const Text('Estudar'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CardScreen()));
          },)
        ],
      ),
    );
  }
}

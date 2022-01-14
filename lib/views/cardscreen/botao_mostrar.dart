import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BotaoMostrar extends StatelessWidget {

  Function() mostrar;
  
  BotaoMostrar(this.mostrar, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[700],
            child: TextButton(
                onPressed: mostrar,
                child: const Text('Mostrar resposta',
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
        ),
      ],
    );
  }
}

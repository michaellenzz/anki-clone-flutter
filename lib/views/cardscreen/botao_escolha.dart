import 'package:flutter/material.dart';

class BotaoEscolha extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final cor;
  final Function() acao;
  const BotaoEscolha(this.title, this.cor, this.acao, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: cor, borderRadius: BorderRadius.circular(30)),
      child: TextButton(
          onPressed: acao,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
    );
  }
}

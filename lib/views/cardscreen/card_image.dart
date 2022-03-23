import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {  // ignore: prefer_typing_uninitialized_variables
  // ignore: prefer_typing_uninitialized_variables
  final _controller;
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const CardImage(this._controller, this.snapshot, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      speed: 230,
      direction: FlipDirection.VERTICAL,
      controller: _controller,
      flipOnTouch: false,
      front: Center(
        child: Image.memory(snapshot.frontImage),
      ),
      back: Center(
        child: Image.memory(snapshot.backImage),
      ),
    );
  }
}
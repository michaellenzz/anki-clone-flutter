import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  // ignore: prefer_typing_uninitialized_variables
  final cartaVirada;
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const CardImage(this.cartaVirada, this.snapshot, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.memory(cartaVirada ? snapshot.backImage : snapshot.frontImage);

    /*FlipCard(
      speed: 0,
      direction: FlipDirection.VERTICAL,
      controller: _controller,
      flipOnTouch: false,
      front: Center(
        child: Image.memory(snapshot.frontImage),
      ),
      back: Center(
        child: Image.memory(snapshot.backImage),
      ),
    );*/
  }
}

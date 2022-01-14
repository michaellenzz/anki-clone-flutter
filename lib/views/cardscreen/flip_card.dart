import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlipCardCustom extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final _controller;
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;

  const FlipCardCustom(this._controller, this.snapshot, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FlipCard(
      speed: 230,
      fill: Fill.fillFront,
      direction: FlipDirection.VERTICAL,
      controller: _controller,
      flipOnTouch: false,
      front: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
          width: width,
          height: width / 2,
          child: Center(
            child: Text(snapshot.front,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          )),
      back: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
          width: width,
          height: width / 2,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.front,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                const Divider(
                  height: 20,
                  thickness: 1,
                ),
                Text(snapshot.back,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          )),
    );
  }
}

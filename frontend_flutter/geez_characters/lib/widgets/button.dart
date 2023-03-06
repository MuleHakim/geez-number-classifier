import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  late String text;
  late Function func;
  double? width;
  Button(this.text, this.func, {super.key, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.blue)),
      child: TextButton(
          onPressed: () => func(),
          child: Text(
            text,
            style: TextStyle(fontSize: width == 150 ? 25:10),
          )),
    );
  }
}

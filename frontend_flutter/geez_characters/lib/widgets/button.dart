import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  late String text;
  late Function func;
  Button(this.text, this.func, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.blue)),
      child: TextButton(
          onPressed: () => func(),
          child: Text(
            text,
            style: const TextStyle(fontSize: 25),
          )),
    );
  }
}

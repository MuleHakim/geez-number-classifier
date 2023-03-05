import 'package:flutter/material.dart';
import 'package:geez_numbers_flutter/pages/home.dart';
import 'package:typewritertext/typewritertext.dart';

import '../widgets/button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Image(image: AssetImage('assets/images/logo.png')),
          ),
          const Center(
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.blue, fontSize: 30),
              child: Text(
                "Geez Number Detector",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: MediaQuery.of(context).orientation.name == "portrait"
                ? 150
                : 75,
            child: const TypeWriterText(
              text: Text(
                "This application can detect some geez numbers. It can recognize digits from 0 - 9. Just give it an image containing the numbers, and it can detect that. Remember to give it an image that has the number lying in the center.",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    color: Colors.blue),
                textAlign: TextAlign.justify,
              ),
              duration: Duration(milliseconds: 65),
            ),
          ),
          Container(
            margin: EdgeInsets.all(
                MediaQuery.of(context).orientation.name == "portrait" ? 50 : 5),
            child: Button(
              "start",
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

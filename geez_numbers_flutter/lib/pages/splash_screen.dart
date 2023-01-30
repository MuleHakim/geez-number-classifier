import 'package:flutter/material.dart';
import 'package:geez_numbers_flutter/pages/home.dart';

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
      color: const Color.fromARGB(255, 1, 3, 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Image(image: AssetImage('assets/images/logo.png')),
          ),
          const Center(
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.blue, fontSize: 25),
              child: Text(
                "Geez Number Detector",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(75),
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

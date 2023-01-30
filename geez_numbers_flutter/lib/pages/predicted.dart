import 'dart:convert';

import "package:flutter/material.dart";
import 'package:geez_numbers_flutter/api/urls.dart';
import "package:http/http.dart" as http;
import "package:http/http.dart";

class PredictedNumber extends StatefulWidget {
  PredictedNumber({super.key});
  @override
  PredictedNumberState createState() => PredictedNumberState();
}

class PredictedNumberState extends State<PredictedNumber> {
  Client client = http.Client();
  String _number = "";

  @override
  void initState() {
    _getPredictedNumber();
    super.initState();
  }

  _getPredictedNumber() async {
    _number = json.decode(
            ((await client.get(Uri.parse(ApiUrls.predictNumberUrl))).body))
        as String;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Container(
            width:100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue
              )

            ),

              child: Center(
                child: Text("${_number}",
                    style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              )),
        ));
  }
}

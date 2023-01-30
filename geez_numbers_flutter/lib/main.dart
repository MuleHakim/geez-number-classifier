import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geez_numbers_flutter/api/urls.dart';
import 'package:geez_numbers_flutter/pages/splash_screen.dart';
import  "package:http/http.dart" as http;
import  "package:http/http.dart";
import 'models/geez_numbers.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
      home: SplashScreen()));
}


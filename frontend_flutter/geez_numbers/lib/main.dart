import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geez_numbers_flutter/api/urls.dart';
import 'package:geez_numbers_flutter/pages/splash_screen.dart';
import  "package:http/http.dart" as http;
import  "package:http/http.dart";
import 'models/geez_numbers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()));
  });
}


import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geez_numbers_flutter/pages/predicted.dart';
import 'package:image_picker/image_picker.dart';

import '../api/urls.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  File? image;

  Future PickFromFile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future PickFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  void _upload(File? file) async {
    String? fileName = file?.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      "image_url": await MultipartFile.fromFile(
        "${file?.path}",
        filename: fileName,
      ),
      "creation_date":"${DateTime.now()}"
    });

    Dio dio = new Dio();

    dio.post(ApiUrls.createUrl, data: data).then((response) {
      var jsonResponse = jsonDecode(response.toString());
      print(jsonResponse);
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 1, 15, 26),
            image: DecorationImage(
                image: AssetImage("assets/images/logo.png"), opacity: 0.15)),
        child: Column(
          mainAxisAlignment: image == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: image != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 400,
                            width: 400,
                            margin: const EdgeInsets.only(
                                top: 100, bottom: 100, left: 10, right: 10),
                            padding: const EdgeInsets.all(0),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 9, 70, 121),
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 250,
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blue)),
                            child: TextButton(
                                onPressed: () {
                                  _upload(image);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=> PredictedNumber())
                                  );
                                },
                                child: const Text(
                                  "Predict",
                                  style: TextStyle(fontSize: 25),
                                )),
                          )
                        ],
                      )
                    : const SizedBox(
                        height: 100,
                      )),
            image == null
                ? Column(
                    children: [
                      Button("File", () => PickFromFile()),
                      Button("Camera", () => PickFromCamera()),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Button("File", () => PickFromFile()),
                      Button("Camera", () => PickFromCamera()),
                    ],
                  )
          ],
        ),
      ),

    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geez_number_classifier_flutter/utils.dart';
import 'package:image_picker/image_picker.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => PredictPageState();
}

class PredictPageState extends State<PredictPage> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 1, 15, 26),
          image: DecorationImage(
              image: AssetImage("./images/logo.png"), opacity: 0.15)),
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
                              onPressed: () {},
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
    );
  }
}

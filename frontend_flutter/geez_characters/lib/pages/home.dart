import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geez_numbers_flutter/pages/sketcher.dart';
import 'package:geez_numbers_flutter/utility/http.dart';
import 'package:image_picker/image_picker.dart';
import '../api/urls.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  final String? path;
  const HomePage({super.key, this.path});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  File? image;
  String number = "click predict button to continue";
  var word_dict = {
    0: "-",
    1: "፩",
    2: "፪",
    3: "፫",
    4: "፬",
    5: "፭",
    6: "፮",
    7: "፯",
    8: "፰",
    9: "፱",
    10: '፲',
    11: '፳',
    12: '፴',
    13: '፵',
    14: "፶",
    15: '፷',
    16: '፸',
    17: "፹",
    18: "፺",
    19: "፻",
  };

  @override
  void initState() {
    if (widget.path != null){
      PickFromFile(path: widget.path);
    }
  }

  void reset_number() {
    number = "click the predict button to continue";
    setState(() {});
  }

  Future PickFromFile({path = null}) async {
    try {
      late File imageTemp;
      if (path == null) {
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery);
        if (image == null) return;
        imageTemp = File(image.path);
      }
      else{
        imageTemp = File(path);
      }
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    reset_number();
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
    reset_number();
  }

  void _upload(File? file) async {
    String? fileName = file?.path.split('/').last;
    FormData data = FormData.fromMap({
      "image_url": await MultipartFile.fromFile(
        "${file?.path}",
        filename: fileName,
      ),
      "creation_date": "${DateTime.now()}"
    });

    Dio dio = new Dio();

    dio.post(ApiUrls.createUrl, data: data).then((response) async {
      var jsonResponse = jsonDecode(response.toString());
      number = json.decode(
              ((await client.get(Uri.parse(ApiUrls.predictNumberUrl))).body))
          as String;
      setState(() {});
      number = word_dict[int.parse(number)]!;
    }).catchError((error) => print(error));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: const Color.fromARGB(255,255,255,255),
        ),
        child: Column(
          mainAxisAlignment: image == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: image != null
                  ? Expanded(
                      child:
                          MediaQuery.of(context).orientation.name == "portrait"
                              ? get_column()
                              : get_row(),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 350,
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              "Choose the image from a folder or take a picture using the camera",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Button("File", () => PickFromFile()),
                          Button("Camera", () => PickFromCamera()),
                          Button("Sketch", ()
                          {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Sketcher(),
                                      ),
                                    );
                                  }),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Column get_column() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 400,
            width: 400,
            margin: const EdgeInsets.only(
                top: 100, bottom: 50, left: 15, right: 15),
            padding: const EdgeInsets.all(0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 9, 70, 121), spreadRadius: 1),
              ],
            ),
            child: Image.file(
              image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              Container(
                height: 75,
                child: Text(
                  number,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: number.length <= 2 ? 60 : 20),
                  textAlign: TextAlign.center,
                ),

              ),
              Container(
                width: 250,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(0),
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blue)),
                child: TextButton(
                    onPressed: () {
                      number = "processing image...";
                      setState(() {});
                      _upload(image);
                    },
                    child: const Text(
                      "Predict",
                      style: TextStyle(fontSize: 25),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button("Back", () => Navigator.pop(context))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Row get_row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 400,
            width: 400,
            margin:
                const EdgeInsets.only(top: 35, bottom: 35, left: 15, right: 15),
            padding: const EdgeInsets.all(0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 9, 70, 121), spreadRadius: 1),
              ],
            ),
            child: Image.file(
              image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 75,
              child: Text(
                number,
                style: TextStyle(
                    color: Colors.blue, fontSize: number.length <= 2 ? 60 : 20),
              textAlign: TextAlign.center, ),

            ),
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue)),
              child: TextButton(
                  onPressed: () {
                    number = "processing image...";
                    setState(() {});
                    _upload(image);
                  },
                  child: const Text(
                    "Predict",
                    style: TextStyle(fontSize: 25),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button("Back", () => Navigator.pop(context))
              ],
            ),
          ],
        )
      ],
    );
  }
}


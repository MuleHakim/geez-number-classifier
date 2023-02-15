import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geez_numbers_flutter/utility/http.dart';
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
  String number = "click predict button to continue";
  var word_dict = {0:"-", 1:"፩", 2:"፪", 3:"፫", 4:"፬", 5:"፭", 6:"፮", 7:"፯", 8:"፰", 9:"፱", 10:'ሀ',11:'ሁ',12:'ሂ',13:'ሃ',14:"ሄ",15:'ህ',16:'ሆ',17:"ለ",18:"ሉ",
  19:"ሊ",20:"ላ",21:"ሌ",22:"ል",23:"ሎ",24:"ሐ",25:"ሑ",26:"ሒ",27:"ሓ",28:"ሔ",29:"ሕ",30:"ሖ",
  31:"መ",32:"ሙ",33:"ሚ",34:"ማ",35:"ሜ",36:"ም",37:"ሞ"
  };

  void reset_number(){
    number = "click predict button to continue";
    setState((){});
  }

  Future PickFromFile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
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
      "creation_date":"${DateTime.now()}"
    });

    Dio dio = new Dio();

    dio.post(ApiUrls.createUrl, data: data).then((response) async{
      var jsonResponse = jsonDecode(response.toString());
      number = json.decode(((await client.get(Uri.parse(ApiUrls.predictNumberUrl))).body)) as String;
      setState((){});
      number = word_dict[int.parse(number)]!;
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: const Color.fromARGB(255, 1, 3, 22),
            ),
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
                                top: 100, bottom: 50, left: 15, right: 15),
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
                            height: 55,
                            child: Text(number, style: TextStyle(color: Colors.blue, fontSize: number.length <= 2? 60 : 25),),
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
                                  number = "please wait";
                                  setState((){});
                                  _upload(image);
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
                      ),
            ),
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

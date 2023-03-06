import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_sketcher/image_sketcher.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'home.dart';

class Sketcher extends StatefulWidget {
  const Sketcher({Key? key}) : super(key: key);

  @override
  _SketcherState createState() => _SketcherState();
}

class _SketcherState extends State<Sketcher> {
  final _imageKey = GlobalKey<ImageSketcherState>();
  final _key = GlobalKey<ScaffoldState>();

  Color color = Colors.black;

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File(fullPath);
    imgFile.writeAsBytesSync(image!);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(path:fullPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(backgroundColor: Colors.grey,elevation: 0,),
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          ImageSketcher.asset(
            "assets/images/sample.jpeg",
            key: _imageKey,
            scalable: true,
            initialStrokeWidth: 40,
            initialColor: color,
            initialPaintMode: PaintMode.freeStyle,
            controlPosition: Alignment.topCenter,
            isControllerOverlay: true,
            controllerAxis: ControllerAxis.vertical,
            controllerDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            controllerMargin: EdgeInsets.all(0),
            toolbarBGColor: Colors.white,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              margin: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.clearAll();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.undo();
                    },
                    icon: const Icon(Icons.undo),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.changePaintMode(PaintMode.line);
                    },
                    icon: const Icon(Icons.mode_edit),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.changeBrushWidth(20);
                    },
                    icon: const Icon(Icons.brush),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.addText('Abcd');
                    },
                    icon: const Icon(Icons.text_fields),
                  ),
                  IconButton(
                    onPressed: saveImage,
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
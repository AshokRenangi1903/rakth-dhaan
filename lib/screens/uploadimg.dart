import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImg extends StatefulWidget {
  const UploadImg({Key? key}) : super(key: key);

  @override
  State<UploadImg> createState() => _UploadImgState();
}

class _UploadImgState extends State<UploadImg> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("upload img")),
      body: Container(
        child: Column(children: [
          Container(
            child: null,
          ),
          ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: Text("upload images"),
          )
        ]),
      ),
    );
  }

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReqImg extends StatefulWidget {
  String reqImg;
  ReqImg({Key? key, required this.reqImg}) : super(key: key);

  @override
  State<ReqImg> createState() => _ReqImgState();
}

class _ReqImgState extends State<ReqImg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple, title: Text("Prescription Image")),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: 6.0,
            child: Image(
              image: NetworkImage(widget.reqImg as String),
            ),
          ),
        ),
      ),
    );
  }
}

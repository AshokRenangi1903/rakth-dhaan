
import 'dart:developer';

import 'package:flutter/material.dart';

import 'donarsList.dart';

class CheckBG extends StatefulWidget {
  var bg;
  CheckBG({Key? key, required this.bg}) : super(key: key);

  @override
  State<CheckBG> createState() => _CheckBGState();
}

class _CheckBGState extends State<CheckBG> {
  @override
  Widget build(BuildContext context) {
    var bg = '${widget.bg}';
    return ElevatedButton(
      onPressed: () {
        log("working");
        setState(() {
          selBG = [bg];
        });
        print(selBG);
      },
      child: Text(bg),
    );
  }
}

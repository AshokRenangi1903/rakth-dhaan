import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DonateOrReceive extends StatefulWidget {
  const DonateOrReceive({Key? key}) : super(key: key);

  @override
  State<DonateOrReceive> createState() => _DonateOrReceiveState();
}

class _DonateOrReceiveState extends State<DonateOrReceive> {
  var bgs = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
  var donateBg = ['A+', 'AB+'];
  var receiveBg = ['A+', 'O+', 'A-', 'O-'];
  var selBg = 'A+';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Donate or Receive"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Select Donar / Patient Blood Group: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  value: selBg,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 27),
                  items: bgs.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selBg = item as String;
                    });
                    setState(() {
                      if (selBg == 'A+') {
                        setState(() {
                          donateBg = ['A+', 'AB+'];
                          receiveBg = ['A+', 'O+', 'A-', 'O-'];
                        });
                      } else if (selBg == 'B+') {
                        setState(() {
                          donateBg = ['B+', 'AB+'];
                          receiveBg = ['B+', 'O+', 'B-', 'O-'];
                        });
                      } else if (selBg == 'AB+') {
                        setState(() {
                          donateBg = ['AB+'];
                          receiveBg = [
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ];
                        });
                      } else if (selBg == 'O+') {
                        setState(() {
                          donateBg = ['A+', 'B+', 'AB+', 'O+'];
                          receiveBg = ['O+', 'O-'];
                        });
                      } else if (selBg == 'A-') {
                        setState(() {
                          donateBg = ['A+', 'AB+', 'A-', 'AB-'];
                          receiveBg = ['A-', 'O-'];
                        });
                      } else if (selBg == 'B-') {
                        setState(() {
                          donateBg = ['B+', 'AB+', 'B-', 'AB-'];
                          receiveBg = ['B-', 'O-'];
                        });
                      } else if (selBg == 'AB-') {
                        setState(() {
                          donateBg = ['AB-', 'AB+'];
                          receiveBg = ['A-', 'B-', 'AB-', 'O-'];
                        });
                      } else if (selBg == 'O-') {
                        setState(() {
                          donateBg = [
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ];
                          receiveBg = ['O-'];
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                ),
              ],
            ),

            //donating blood groups
            Container(
              decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(18)),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    selBg + " Donar can donate blood to... ",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text(
                      donateBg.join(', '),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            //sizedBox

            //receiving blood groups
            Container(
              decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(18)),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    selBg + " Patient can receive blood from... ",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      receiveBg.join(', '),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

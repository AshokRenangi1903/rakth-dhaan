import 'package:flutter/material.dart';

class TapProfile extends StatefulWidget {
  const TapProfile({Key? key}) : super(key: key);

  @override
  State<TapProfile> createState() => _TapProfileState();
}

class _TapProfileState extends State<TapProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("what the shit"),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("one"),
                ),
                Tab(
                  child: Text("two"),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Text("one"),
            Text("two"),
          ]),
        ));
  }
}

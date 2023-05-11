import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PresentProfile extends StatefulWidget {
  const PresentProfile({Key? key}) : super(key: key);

  @override
  State<PresentProfile> createState() => _PresentProfileState();
}

class _PresentProfileState extends State<PresentProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("phone", isEqualTo: "+911212121212")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> user_Map = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;

                    return ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        user_Map["name"] + "(${user_Map["town"]})",
                      ),
                      trailing: Text(
                        user_Map["bloodgroup"],
                      ),
                      subtitle: Text(
                        user_Map["phone"],
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

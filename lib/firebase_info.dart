import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';

FirebaseFirestore fire = FirebaseFirestore.instance;

Map<String, dynamic> userData = {};

Future getFirebaseInfo() async {
  await fire
      .collection('Users')
      .where("Name", isEqualTo: "Justin Cheng")
      .get()
      .then(
        (snapshot) => userData = snapshot.docs.first.data(),
      );
}

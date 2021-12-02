import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:spartans_eatup/main.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';/*

class RestaurantDashboard extends State<MyApp> {
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid.toString());

    return FutureBuilder<DocumentSnapshot>(
      future: restaurants
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data!.data());

          Restaurant restaurant = Restaurant.fromJson(
              snapshot.data!.data() as Map<String, dynamic>);

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(data);

          return Container(
              color: Colors.blue[900],
              child: Column(children: [
                Text(restaurant.name),
                ElevatedButton(onPressed: () {}, child: Text("Sad")),
              ]));
        }

        return Text("loading");
      },
    );
  }
}
*/
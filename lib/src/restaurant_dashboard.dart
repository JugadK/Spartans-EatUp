import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:spartans_eatup/main.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';

import 'models/student.dart';

class RestaurantDashboard extends StatefulWidget {
  final String restaurantName;
  const RestaurantDashboard({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _RestaurantDashboard createState() => _RestaurantDashboard();
}

class _RestaurantDashboard extends State<RestaurantDashboard> {
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<List<Student>> getStudentsOrders() async {
    // DocumentSnapshot test =
    //   await students.doc("81OR8a0DpdbwSc0BgRWvqCW8zyz2").get();

    List<Student> responseStudents = [];
    DocumentSnapshot restaurantSnapshot = await restaurants
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    Restaurant restaurant =
        Restaurant.fromJson(restaurantSnapshot.data() as Map<String, dynamic>);
    for (String element in restaurant.currentOrderUsers) {
      DocumentSnapshot studentSnapshot =
          await students.doc("81OR8a0DpdbwSc0BgRWvqCW8zyz2").get();

      responseStudents.add(
          Student.fromJson(studentSnapshot.data() as Map<String, dynamic>));
    }
    ;

    return responseStudents;
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid.toString());

    return FutureBuilder<List<Student>>(
      future: getStudentsOrders(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Student>> asyncSnapshot) {
        List<Student>? QueriedStudents = asyncSnapshot.data;
        if (asyncSnapshot.hasError) {
          return Text("Something went wrong");
        }

        print(QueriedStudents.toString() + " fdf");

        if (asyncSnapshot.connectionState == ConnectionState.done) {
          return Column(children: [
            Table(
              /*children: QueriedStudents!
                  .map((student) => TableRow(
                          children: student.orders.map((e) {
                        print("hello");
                        return Text("hello");
                      }).toList()))
                  .toList(),*/
              children: QueriedStudents!
                  .map((student) =>
                      TableRow(children: [Text(student.orders.toString())]))
                  .toList(),
            ),
          ]);
          ;
        }

        return Text("loading");
      },
    );
  }
}

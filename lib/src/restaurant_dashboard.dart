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

  Future<Map<String, dynamic>> getStudentsOrders() async {
    // DocumentSnapshot test =
    //   await students.doc("81OR8a0DpdbwSc0BgRWvqCW8zyz2").get();

    Map<String, dynamic> returnMap = {};

    List<Student> responseStudents = [];

    DocumentSnapshot restaurantSnapshot = await restaurants
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    Restaurant restaurant =
        Restaurant.fromJson(restaurantSnapshot.data() as Map<String, dynamic>);
    print(restaurant.currentOrderUsers);
    for (String element in restaurant.currentOrderUsers) {
      DocumentSnapshot studentSnapshot =
          await students.doc(element.toString()).get();

      print(studentSnapshot.data());

      responseStudents.add(
          Student.fromJson(studentSnapshot.data() as Map<String, dynamic>));
    }
    ;

    returnMap["restaurant"] = restaurant;

    returnMap["responseStudents"] = responseStudents;
    print(responseStudents);
    return returnMap;
  }

  // Change the current List of users that have orders with the restaruant

  Future<void> writeRestaurantOrders(Restaurant res, String id) async {
    CollectionReference restaurants =
        FirebaseFirestore.instance.collection('restaurants');

    print("fdsaf" + res.toJson().toString());

    await restaurants
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .set(res.toJson());

    await students.doc(id).update({"orders": []});

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Didnt want to add student ID in db as a field, since we iterate through students
    // sequencitally, the 0th student is the same student referenced in the 0th part of the currentOrderUsers in restaruant
    // Yes this is dumb
    int currentStudentIndex = -1;
    print(FirebaseAuth.instance.currentUser!.uid.toString());

    return FutureBuilder<Map<String, dynamic>>(
      future: getStudentsOrders(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>> asyncSnapshot) {
        List<Student>? QueriedStudents =
            asyncSnapshot.data!["responseStudents"];
        Restaurant currentRestaruant = asyncSnapshot.data!["restaurant"];
        if (asyncSnapshot.hasError) {
          return Text("Something went wrong");
        }

        if (asyncSnapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              home: Scaffold(
                  body: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                Container(
                  padding: EdgeInsets.only(top: 40, right: 40, left: 40),
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    /*children: QueriedStudents!
                  .map((student) => TableRow(
                          children: student.orders.map((e) {
                        print("hello");
                        return Text("hello");
                      }).toList()))
                  .toList(),*/
                    children: QueriedStudents!.map((student) {
                      currentStudentIndex++;
                      return TableRow(children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(student.email,
                                style: TextStyle(fontSize: 20.0))),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: student.orders.map((order) {
                              return Text(order.toString(),
                                  style: TextStyle(fontSize: 20.0));
                            }).toList()),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  String studentDocId = currentRestaruant
                                      .currentOrderUsers[currentStudentIndex];
                                  currentRestaruant.currentOrderUsers
                                      .removeAt(currentStudentIndex);

                                  writeRestaurantOrders(
                                      currentRestaruant, studentDocId);
                                  ;
                                },
                                child: Text("Complete Order"))
                          ],
                        )
                      ]);
                    }).toList(),
                  ),
                )
              ]))));
          ;
        }

        return Text("loading");
      },
    );
  }
}

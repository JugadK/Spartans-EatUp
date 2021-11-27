import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spartans_eatup/main.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/student.dart';

class TestRestaurant extends State<MyApp> {
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> writeOrders(List<Order> orders) async {
    List<dynamic> order = [];
    for (var element in orders) {
      order.add(element.toJson());
    }

    await sendOrderToRestaurant();

    print(order);
    return students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .update({"orders": order})
        .then((value) => print("orders array changed"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  Future<void> sendOrderToRestaurant() async {
    CollectionReference restaurants =
        FirebaseFirestore.instance.collection('restaurants');

    QuerySnapshot snapshot = await restaurants
        .where('name', isEqualTo: "Amogus")
        .where('currentOrderUsers',
            whereNotIn: [FirebaseAuth.instance.currentUser!.uid]).get();

    print("pfkladf");
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((element) {
        element.reference.update({
          "currentOrderUsers":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      });
    } else {
      print("User already has order in restaurant");
    }
  }

  // Code modified from https://firebase.flutter.dev/docs/firestore/usage/
  // If rehauled please remove
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          students.doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),
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

          Student student =
              Student.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(data);

          return Container(
              color: Colors.blue[900],
              child: Column(children: [
                Text(student.orders.toString()),
                ElevatedButton(
                    onPressed: () {
                      //
                      // Here we add the order to the array orders
                      // This will be used for telling the restaurant what to m
                      // make
                      //
                      // we can manipulate this student object
                      // before we actually write to the database, letting the
                      // UI add and remove orders before writing
                      //

                      student.orders.add(Order(
                          name: "Rice",
                          price: Decimal.parse("22.99"),
                          restaurant: "Amogus"));

                      //
                      // writeOrders will actually write the orders to the database
                      // this will only change the orders array
                      //

                      writeOrders(student.orders);
                      print(student.orders);
                    },
                    child: Text("Rice")),
              ]));
        }

        return Text("loading");
      },
    );
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:spartans_eatup/main.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/student.dart';

import 'package:get/get.dart';
import 'package:spartans_eatup/src/cart_controller.dart';

class RestaurantMenu extends StatefulWidget {
  final String restaurantName;
  const RestaurantMenu({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _RestaurantMenu createState() => _RestaurantMenu();
}

class _RestaurantMenu extends State<RestaurantMenu> {
  bool gotOrdersFromDatabase = false;
  List<Widget> menuWidgets = [];
  List<Widget> currentOrders = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  final cartController = Get.put(CartController());

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

  Future<void> getCurrentOrders() async {
    List<Widget> orders = [];
    DocumentSnapshot studentSnapshot = await students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    Student student =
        Student.fromJson(studentSnapshot.data() as Map<String, dynamic>);

    print(student.orders);

    student.orders.forEach((element) {
      orders.add(
        Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              //padding: const EdgeInsets.only(left: 20, top: 145),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.name + " " + element.price.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
    setState(() {
      currentOrders = orders;
    });
  }

  void addOrderWidget(Order order) {
    currentOrders.add(
      Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Container(
            //padding: const EdgeInsets.only(left: 20, top: 145),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.name + " " + order.price.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ],
            ),
          )),
    );

    setState(() {
      currentOrders = currentOrders;
    });
  }

  // Retrieves the menu from firebase and turns it into widgets we can
  // display
  Future<void> getMenu(String restaurantName, String search) async {
    DocumentSnapshot studentSnapshot = await students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    Student student =
        Student.fromJson(studentSnapshot.data() as Map<String, dynamic>);

    List<Widget> menuData = [];
    List<Order> menu = [];

    QuerySnapshot snapshot =
        await restaurants.where('name', isEqualTo: widget.restaurantName).get();

    print(snapshot.docs.first.data());
    if (snapshot.docs.isNotEmpty) {
      List<dynamic> responseJson = snapshot.docs.first.get("menu");
      for (var element in responseJson) {
        menu.add(Order.fromJson(element));
      }

      menu.forEach((element) async {
        if (element.name.substring(
                  0,
                  search.length,
                ) ==
                search ||
            search == "") {
          var link =
              "https://firebasestorage.googleapis.com/v0/b/spartans-eatup.appspot.com/o/rice.jpg?alt=media&token=14d5b354-5d05-450b-ad5e-d64b81df0c7b";

          menuData.add(GestureDetector(
              onTap: () async {
                cartController.addOrder(element);
                student.orders.add(element);
                addOrderWidget(element);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added")),
                );
              },
              child: Column(children: [
                Container(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(element.picture),
                  ),
                ),
                Container(
                    height: 20,
                    child: Text(
                      element.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000),
                      ),
                    ))
              ])));
        } else {}
      });

      //  menu.add(Order.fromJson(element))
    } else {
      print("Restaurant Name does not exist");
    }

    /*menuData.add(ElevatedButton(
      child: Text("Remove Last Order"),
      onPressed: () {
        if (student.orders.isEmpty) {
        } else {
          student.orders.removeLast();
          currentOrders.removeLast();
        }
        setState(() {
          currentOrders = currentOrders;
        });
      },
    ));

    menuData.add(ElevatedButton(
        onPressed: () {
          writeOrders(student.orders);
        },
        child: Text("Apply Changes"))); */

    setState(() {
      menuWidgets = menuData;
    });
  }

  Future<void> sendOrderToRestaurant() async {
    QuerySnapshot snapshot = await restaurants
        .where('name', isEqualTo: widget.restaurantName)
        .where('currentOrderUsers',
            whereNotIn: [FirebaseAuth.instance.currentUser!.uid]).get();

    print("pfkladf");
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        element.reference.update({
          "currentOrderUsers":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    } else {
      print("User already has order in restaurant");
    }
  }

  // Code modified from https://firebase.flutter.dev/docs/firestore/usage/
  // If rehauled please remove
  Widget build(BuildContext context) {
    if (menuWidgets.isEmpty) {
      print("hello");
      getMenu(widget.restaurantName, "");
    }
    // This is so we can tell the differene between the user
    // removing all thier orders and the the data base having no orders stored
    if (currentOrders.isEmpty && !gotOrdersFromDatabase) {
      print("hello2");
      getCurrentOrders();
      gotOrdersFromDatabase = true;
    }

    // students.doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),

    return Container(
        color: Color(0xFFFFFFFF),
        child: Column(
          children: [
            //  Container(
            // height: 140,

            Container(
              padding: const EdgeInsets.only(left: 10, top: 80),
              height: 140,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff663eb6),
              child: Text(widget.restaurantName,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFFFFFFFF),
                  )),
            ),
            CupertinoSearchTextField(
              onSubmitted: (value) {
                getMenu(widget.restaurantName, value);
              },
            ),

            Expanded(
                child: Material(
                    child: GridView.count(
              //padding: const EdgeInsets.all(1),
              primary: false,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: menuWidgets,
              crossAxisCount: 2,
            )))
          ],
        ));
  }
}

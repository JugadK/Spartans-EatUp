import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

import 'package:get/get.dart';
import 'package:spartans_eatup/src/cart_orders.dart';
import 'package:spartans_eatup/src/cart_total.dart';
import 'package:spartans_eatup/src/current_orders.dart';
import 'package:spartans_eatup/src/restaurant_menu.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spartans_eatup/main.dart';
import 'package:decimal/decimal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spartans_eatup/src/cart_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';

class MyBag extends StatefulWidget {
  const MyBag({Key? key}) : super(key: key);

  @override
  _MyBag createState() => _MyBag();
}

class _MyBag extends State<MyBag> {
//
  bool gotOrdersFromDatabase = false;
  List<Widget> menuWidgets = [];
  List<Widget> currentOrders = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  final cartController = Get.put(CartController());

  Future<void> writeOrders(RxMap<dynamic, dynamic> orders) async {
    List<dynamic> order = [];
    for (var element in orders.keys) {
      order.add(element.toJson());
    }

    //await sendOrderToRestaurant();

    print(order);
    return students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .update({"orders": order})
        .then((value) => print("orders array changed"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.white,
      body: Container(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      "My Bag",
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xffF6B92E),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      "Restaurants",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CurrentOrders(),
                            fullscreenDialog: true));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 200),
                    child: const Text(
                      " Go to Current Orders",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                CartOrders(),
                CartTotal(),
                ElevatedButton(
                  onPressed: () {
                    writeOrders(cartController.orders);
                    cartController.clearAllOrders();
                    Get.snackbar(
                        "Checkout Successful", "Your order is now in process",
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 2));
                  },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          )),
    );
  }
}

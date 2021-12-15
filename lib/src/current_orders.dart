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

import 'package:spartans_eatup/src/models/student.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({Key? key}) : super(key: key);

  @override
  _CurrentOrders createState() => _CurrentOrders();
}

class _CurrentOrders extends State<CurrentOrders> {
//
  bool gotOrdersFromDatabase = false;
  List<Widget> menuWidgets = [];
  List<Widget> currentOrders = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  final cartController = Get.put(CartController());

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
            child: Container(
                //padding: const EdgeInsets.only(left: 20, top: 145),
                child: Column(children: [
              Container(
                child: CircleAvatar(
                  radius: 60,
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
            ]))),
      );
    });
    setState(() {
      currentOrders = orders;
    });
  }
//

  @override
  Widget build(BuildContext context) {
    if (currentOrders.isEmpty) {
      getCurrentOrders();
    }

    return Scaffold(
        backgroundColor: color.AppColor.white,
        body: Container(
            padding: const EdgeInsets.only(left: 10, top: 50),
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                //  Container(
                // height: 140,
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Text(
                      "Current Orders",
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
                      "Orders in progress",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 200),
                    child: const Text(
                      " Go to MyBag",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),

                Expanded(
                    child: Material(
                        color: const Color(0xFFFFFFFF),
                        child: GridView.count(
                          //padding: const EdgeInsets.all(1),
                          primary: false,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          children: currentOrders,
                          crossAxisCount: 2,
                        )))
              ],
            )));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spartans_eatup/main.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/student.dart';
import 'package:spartans_eatup/src/restaurant_pages/test_restaurant.dart';

class HomePage extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TestRestaurant().build(context)));
      },
      child: Text("Go to Test Restaurant"),
    ));
  }
}

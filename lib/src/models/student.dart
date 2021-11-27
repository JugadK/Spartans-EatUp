import 'package:spartans_eatup/main.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/order_list.dart';
import 'package:decimal/decimal.dart';

class Student {
  String email;
  List<Order> orders;

  Student({required this.email, required this.orders}) {
    if (email.substring(email.length - 9, email.length) != "@sjsu.edu") {
      throw ("Email is not an sjsu email");
    }
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    var ordersJson = json['orders'] as List;
    List<Order> orders =
        ordersJson.map((orderJson) => Order.fromJson(orderJson)).toList();
    //List<Order> orders = json['orders'];
    String email = json['email'];

    return Student(email: email, orders: orders);
  }

  /*Student fromJson(Map<String, Object?> json) {
    orders = json['orders']! as List<Order>;
    email = json['email']! as String;

    return Student(email: email, orders: orders);
  } */

  Map<String, dynamic> toJson() {
    return {'email': email, 'orders': orders};
  }
}

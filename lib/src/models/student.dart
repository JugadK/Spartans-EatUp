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

  //
  String? phoneNumber;
  String? firstName;
  String? lastName;

  Student(
      {required this.email,
      required this.orders,
      this.firstName,
      this.lastName,
      this.phoneNumber}) {
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

    String phoneNumber = json['phoneNumber'];
    String firstName = json['firstName'];
    String lastName = json['lastName'];

    return Student(
        email: email,
        orders: orders,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber);
  }

  /*Student fromJson(Map<String, Object?> json) {
    orders = json['orders']! as List<Order>;
    email = json['email']! as String;

    return Student(email: email, orders: orders);
  } */

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'orders': orders
    };
  }
}

import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/models/order_list.dart';

class Restaurant {
  String email;
  String name;
  List<String> currentOrderUsers;

  Restaurant({
    required this.email,
    required this.name,
    required this.currentOrderUsers,
  });

  factory Restaurant.fromJson(Map<String, dynamic?> json) {
    String name = json['name']! as String;
    String email = json['email']! as String;
    List<String> currentOrderUsers = List.from(json['currentOrderUsers']);

    return Restaurant(
        email: email, name: name, currentOrderUsers: currentOrderUsers);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'current': currentOrderUsers};
  }
}

import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/models/order_list.dart';

class Restaurant {
  String email;
  String name;
  List<OrderList> currentOrders;

  Restaurant({
    required this.email,
    required this.name,
    required this.currentOrders,
  });

  Restaurant fromJson(Map<String, Object?> json) {
    name = json['name']! as String;
    email = json['email']! as String;
    currentOrders = json['currentorders'] as List<OrderList>;

    return Restaurant(email: email, name: name, currentOrders: currentOrders);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'currentOrders': currentOrders};
  }
}

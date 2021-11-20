import 'package:spartans_eatup/main.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class OrderList {
  final List<Order> orders;
  final int orderId;

  OrderList({
    required this.orders,
    required this.orderId,
  });

  OrderList.fromJson(Map<String, Object?> json)
      : this(
          orders: json['orders']! as List<Order>,
          orderId: json['orderId']! as int,
        );
}

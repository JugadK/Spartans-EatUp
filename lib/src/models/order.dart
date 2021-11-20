import 'package:spartans_eatup/main.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class Order {
  final String name;

  //REMEMBER : all prices for items need to be stored in integers, cpus suck
  // at figuring out base 10 decimals :( , we have to later on

  final int price;

  Order({
    required this.name,
    required this.price,
  });

  Order.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          price: json['price']! as int,
        );
}

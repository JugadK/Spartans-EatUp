import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';

class Order {
  String name;

  //REMEMBER : all prices for items need to be stored in integers, cpus suck
  // at figuring out base 10 decimals :( , we have to later on convert it back
  // to a decimal

  Decimal price;

  String restaurant;

  String picture;

  Order(
      {required this.name,
      required this.price,
      required this.restaurant,
      required this.picture});

  @override
  String toString() {
    return name + " \$" + price.toString();
  }

  Order.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name']! as String,
          price: Decimal.parse(json['price'].toString()),
          restaurant: json['restaurant']! as String,
          picture: json['picture']! as String,
        );

  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price.toJson(), 'restaurant': restaurant};
}

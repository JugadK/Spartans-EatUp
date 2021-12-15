import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';

class Order {
  String name;

  //REMINDER: computers suck at decimal math, we will use this decimal class
  // instead for dealing with money
  // https://pub.dev/packages/decimal

  Decimal price;

  String restaurant;

  String picture;

  // onCurrentMenu purely matters when we ask the user is looking at the
  // the menu, so only in the menu array located in the restaurant model
  // does it have any purpose, it can be ignored in other parts

  bool onCurrentMenu;

  //List<dynamic> tags = [];

  Order({
    required this.name,
    required this.price,
    required this.restaurant,
    required this.picture,
    required this.onCurrentMenu,
    //required this.tags,
  });

  @override
  String toString() {
    return name + " \$" + price.toString();
  }

  Order.fromJson(Map<String, dynamic?> json)
      : this(
          name: json['name']! as String,
          price: Decimal.parse(json['price'].toString()),
          restaurant: json['restaurant']! as String,
          picture: json['picture']! as String,
          onCurrentMenu: json['onCurrentMenu']! as bool,
          // tags: json['tags']! as List<dynamic>
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price.toJson(),
        'restaurant': restaurant,
        'picture': picture,
        'onCurrentMenu': onCurrentMenu,
        //  'tags': tags,
      };
}

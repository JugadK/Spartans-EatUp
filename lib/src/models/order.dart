import 'package:flutter/material.dart';

class Order {
  String name;

  //REMEMBER : all prices for items need to be stored in integers, cpus suck
  // at figuring out base 10 decimals :( , we have to later on convert it back
  // to a decimal

  int price;

  Order({
    required this.name,
    required this.price,
  });

  Order fromJson(Map<String, Object?> json) {
    name = json['name']! as String;
    price = json['price']! as int;

    return Order(name: name, price: price);
  }

  Map<String, dynamic> toJson() => {'name': name, 'price': price};
}

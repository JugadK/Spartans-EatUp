import 'package:get/get.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:collection/collection.dart';

class CartController extends GetxController {
  var _orders = {}.obs;

  void addOrder(Order order) {
    if (_orders.containsKey(order)) {
      _orders[order] += 1;
    } else {
      _orders[order] = 1;
    }

    Get.snackbar("Product Added", "You have added ${order.name} to the cart ",
        snackPosition: SnackPosition.TOP, duration: Duration(seconds: 2));
  }

  get orders => _orders;

  get orderSubtotal =>
      _orders.entries.map((order) => order.key.price * order.value).toList();

//bug here?????
  get total => _orders.entries
      .map((order) => order.key.price * Decimal.parse(order.value.toString()))
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void removeOrder(Order order) {
    if (_orders.containsKey(order) && _orders[order] == 1) {
      _orders.removeWhere((key, value) => key == order);
    } else {
      _orders[order] -= 1;
    }
  }

  void clearAllOrders() {
    _orders.clear();
  }
}

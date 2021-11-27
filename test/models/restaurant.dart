import 'package:decimal/decimal.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/order_list.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Restaurant', () {
    Restaurant panda_express = Restaurant(
        email: "panda@panda.com",
        name: "Panda Express",
        currentOrderUsers: [
          OrderList(orders: [
            Order(
                name: "food",
                price: Decimal.parse("22.00"),
                restaurant: "Panda Express")
          ])
        ]);
    test("has correct email value", () {
      expect(panda_express.email, "panda@panda.com");
    });
    test("has correct name value", () {
      expect(panda_express.name, "Panda Express");
    });
    test("has correct currentOrder value", () {
      expect(panda_express.currentOrderUsers[0].orders[0].name, "food");
      expect(panda_express.currentOrderUsers[0].orders[0].price,
          Decimal.parse("22.00"));
    });
  });
}

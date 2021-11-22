import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/order_list.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spartans_eatup/src/models/student.dart';

void main() {
  group('Student Normal Login', () {
    Student student = Student(
        email: "student@sjsu.edu", orders: [Order(name: "food", price: 22)]);
    test("has correct email value", () {
      expect(student.email, "student@sjsu.edu");
    });
    test("has correct name value", () {
      expect(student.orders[0].name, "food");
      expect(student.orders[0].price, 22);
    });
  });
  group("email", () {
    test("has correct email value", () {
      try {
        Student student = Student(
            email: "student@school.com",
            orders: [Order(name: "food", price: 22)]);
      } catch (e) {
        expect(e.toString(), "Email is not an sjsu email");
      }
    });
  });
}

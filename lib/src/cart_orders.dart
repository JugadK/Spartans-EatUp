import 'package:get/get.dart';
import 'package:spartans_eatup/src/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/models/order.dart';

class CartOrders extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  CartOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 400,
        child: ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (BuildContext context, int index) {
            return CartOrderCard(
              controller: controller,
              order: controller.orders.keys.toList()[
                  index], //might need to double check, caused BadStateException when null?
              quantity: controller.orders.values.toList()[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class CartOrderCard extends StatelessWidget {
  final CartController controller;
  final Order order;
  final int quantity;
  final int index;
  const CartOrderCard({
    Key? key,
    required this.controller,
    required this.order,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(order.picture),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(child: Text(order.name)),
          IconButton(
            onPressed: () {
              controller.removeOrder(order);
            },
            icon: const Icon(Icons.remove_circle),
          ),
          Text('$quantity'),
          IconButton(
            onPressed: () {
              controller.addOrder(order);
            },
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}

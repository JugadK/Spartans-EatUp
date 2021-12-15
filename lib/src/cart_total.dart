import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spartans_eatup/src/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/models/order.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 65,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (!controller.orders.isEmpty)
              Text(
                '${controller.total}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

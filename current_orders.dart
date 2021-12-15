import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({Key? key}) : super(key: key);

  @override
  _CurrentOrders createState() => _CurrentOrders();
}

class _CurrentOrders extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.white,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Text(
                  "Current Orders",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xffF6B92E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Text(
                  "Orders in progress",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 200),
                child: const Text(
                  " Go to MyBag",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

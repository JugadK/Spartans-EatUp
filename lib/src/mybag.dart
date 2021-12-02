import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

class MyBag extends StatefulWidget {
  const MyBag({Key? key}) : super(key: key);

  @override
  _MyBag createState() => _MyBag();
}

class _MyBag extends State<MyBag> {
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
                  "My Bag",
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
                  "Restaurants",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eat_up/account_info.dart';
import 'colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Account(), fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.white,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 300,
                ),
                new Container(
                  child: new IconButton(
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 45.0,
                    ),
                    onPressed: navigateToPage,
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  "Welcome back,",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xffF6B92E),
                    fontWeight: FontWeight.w800,
                    fontFamily: 'LeagueSpartan',
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  "Spartan",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xffF6B92E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                Text(
                  "What are you craving today? Order now and skip the line!",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff000000),
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
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Stack(
                  children: const [
                    Image(image: AssetImage('assets/sm.jpg')),
                    Text(
                      "  Student Union",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  "Convenience & Grocery",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, i) {
                    return Row(
                      children: [
                        Container(
                            height: 165,
                            width: 165,
                            decoration: const BoxDecoration(
                              color: Color(0xff004aa8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Stack(
                                children: const [
                                  Image(
                                    image: AssetImage('assets/vm.jpg'),
                                  ),
                                  Text(
                                    "Village Market",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 17,
                        ),
                        Container(
                            height: 165,
                            width: 165,
                            decoration: const BoxDecoration(
                              color: Color(0xffF6B92E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Stack(
                                children: const [
                                  Image(
                                    image: AssetImage('assets/gm.jpg'),
                                  ),
                                  Text(
                                    "Ginger Market",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}

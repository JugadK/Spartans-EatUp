import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/navbar.dart';
import 'package:spartans_eatup/src/restaurant_login.dart';
import 'colors.dart' as color;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

   static TextEditingController loginEmailController = TextEditingController();
  static TextEditingController loginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 250,
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestaurantLogin(),
                        fullscreenDialog: true));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 200),
                child: const Text(
                  " I'm a Restaurant",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            const Image(
              image: AssetImage('assets/EatUp.jpg'),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 130,
                ),
                Text(
                  " Spartans, Eat Up",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              padding: const EdgeInsets.only(top: 25, left: 60, right: 60),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "E-mail"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavBar(),
                        fullscreenDialog: true));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xff004aa8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "         Get Started         ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 100,
                ),
                Text(
                  "Register your sjsu account",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff000000),
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

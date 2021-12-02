import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/constants.dart';
import 'package:spartans_eatup/src/home_page.dart';
import 'package:spartans_eatup/src/navbar.dart';
import 'package:spartans_eatup/src/restaurant_login.dart';
import 'colors.dart' as color;

class RestaurantMain extends StatefulWidget {
  const RestaurantMain({Key? key}) : super(key: key);

  @override
  _RestaurantMainState createState() => _RestaurantMainState();
}

class _RestaurantMainState extends State<RestaurantMain> {
  String name = 'Restaurant';
  String code = '123 456';
  String manager = 'name';
  String hour1 = '8am';
  String hour2 = '2pm';

  void navigateToPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const RestaurantLogin(),
            fullscreenDialog: true));
  }

  void navigateToPayment() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NavBar(), fullscreenDialog: true));
  }

  void navigateToPast() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NavBar(), fullscreenDialog: true));
  }

  void LogOut() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NavBar(), fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.white,
        body: Container(
            padding: const EdgeInsets.only(top: 60, left: 35, right: 35),
            child: Column(children: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_before,
                      size: 40.0,
                    ),
                    onPressed: navigateToPage,
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    "Hi, " + name,
                    style: const TextStyle(
                      fontSize: 40,
                      color: Color(0xffF6B92E),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: const [
                  Text(
                    "Restaurant Information",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: const [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffF6B92E),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                  ),
                  Text(
                    "code",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffF6B92E),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    width: 129,
                  ),
                  Text(
                    code,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
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
                    "_______________________________",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xCBCBCBCB),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: const [
                  Text(
                    "Manager",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffF6B92E),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    manager,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
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
                    "_______________________________",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xCBCBCBCB),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: const [
                  Text(
                    "Hours available on app",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffF6B92E),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    hour1 + '-' + hour2,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
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
                    "_______________________________",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xCBCBCBCB),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),

              //Account Setting
              Row(
                children: const [
                  Text(
                    "Manage",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "  Edit Menu ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    width: 147,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 35.0,
                    ),
                    onPressed: navigateToPayment,
                  )
                ],
              ),
              Row(
                children: const [
                  Text(
                    " _____________________________",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xCBCBCBCB),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "   Order View",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    width: 139,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 35.0,
                    ),
                    onPressed: navigateToPayment,
                  )
                ],
              ),

              Row(
                children: const [
                  Text(
                    " _____________________________",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xCBCBCBCB),
                    ),
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  const Text(
                    "   Log Out",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    width: 170,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 35.0,
                    ),
                    onPressed: navigateToPayment,
                  )
                ],
              ),

              Row(
                children: const [
                  Text(
                    " _____________________________",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xCBCBCBCB),
                    ),
                  ),
                ],
              ),
            ])));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/constants.dart';
import 'package:spartans_eatup/src/home_page.dart';
import 'package:spartans_eatup/src/login.dart';
import 'package:spartans_eatup/src/navbar.dart';
import 'my_card.dart';
import 'colors.dart' as color;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String username = 'Sammy the Spartan';
  String userID = '014100000';
  String studentEmail = 'sammy.spartan@sjsu.edu';
  String phoneNumPart1 = '408';
  String phoneNumPart2 = '924';
  String phoneNumPart3 = '1000';

  void navigateToPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NavBar(), fullscreenDialog: true));
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
            builder: (context) => const Login(), fullscreenDialog: true));
  }

  void PaymentMethod(){
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=> MyCard(), fullscreenDialog: true ));
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
                      Icons.account_circle_outlined,
                      size: 90.0,
                    ),
                    onPressed: navigateToPage,
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                children: const [
                  Text(
                    "Hi,Spartan",
                    style: TextStyle(
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
                    "Personal Information",
                    style: TextStyle(
                      fontSize: 29,
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
                    "Student ID",
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
                    username,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    userID,
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
                    "Email",
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
                    studentEmail,
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
                    "Number",
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
                    '+1 ' +
                        "(" +
                        phoneNumPart1 +
                        ") " +
                        phoneNumPart2 +
                        '-' +
                        phoneNumPart3,
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
                    "Account Settings",
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
                    "  Change payment method ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    width: 27,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 35.0,
                    ),
                    onPressed: PaymentMethod,
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
                    "   Past Orders",
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
                    onPressed: LogOut,
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

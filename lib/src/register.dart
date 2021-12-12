import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/navbar.dart';
import 'package:spartans_eatup/src/restaurant_login.dart';
import 'package:spartans_eatup/main.dart';
import 'package:spartans_eatup/src/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/restaurant_login.dart';
import 'package:spartans_eatup/src/login.dart';
import 'package:spartans_eatup/src/models/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'colors.dart' as color;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static final _registerFormKey = GlobalKey<FormState>();

  // These Hold the values we will send to Firebase
  static TextEditingController registrationEmailController =
      TextEditingController();
  static TextEditingController registrationPasswordController =
      TextEditingController();

  static TextEditingController firstNameEditingController =
      TextEditingController();
  static TextEditingController lastNameEditingController =
      TextEditingController();
  static TextEditingController phoneNumberEditingController =
      TextEditingController();

  Future<void> registerUser() async {
    String email = registrationEmailController.text;

    String firstName = firstNameEditingController.text;
    String lastName = lastNameEditingController.text;
    String phoneNumber = phoneNumberEditingController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: registrationPasswordController.text,
      );

      User? user = userCredential.user;

      CollectionReference students =
          FirebaseFirestore.instance.collection('students');

      // Call the user's CollectionReference to add a new user
      //students.add(Student(email: email, orders: []).toJson());
      await students
          .doc(
            FirebaseAuth.instance.currentUser!.uid.toString(),
          )
          .set(Student(
                  email: email,
                  orders: [],
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber)
              .toJson())
          .catchError((error) => print("Failed to add user: $error"));

      //Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NavBar(), fullscreenDialog: true));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.white,
      body: Center(
          child: Form(
        key: _registerFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  padding: const EdgeInsets.only(left: 200, top: 10),
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
                height: 20,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 130,
                  ),
                  Text(
                    " Registration Page",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 5, left: 60, right: 60),
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "First Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter First Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: lastNameEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Last Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Last Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneNumberEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: registrationEmailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "E-mail"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: registrationPasswordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_registerFormKey.currentState!.validate()) {
                    registerUser();

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
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
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      "Back to Login",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

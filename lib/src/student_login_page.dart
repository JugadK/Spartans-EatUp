import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:spartans_eatup/src/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/restaurant_login.dart';
import 'package:spartans_eatup/src/student_registration_page.dart';

class StudentLoginPage extends State<MyApp> {
  // Used in order to read values from Registration Form
  static TextEditingController loginEmailController = TextEditingController();
  static TextEditingController loginPasswordController =
      TextEditingController();

  Future<void> logInUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );

      // Home page when login is succesful
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage().build(context)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Code modified from from https://docs.flutter.dev/cookbook/forms/validation
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: Form(
                key: _loginFormKey,
                child: Container(
                    width: width * 0.8,
                    height: height * 0.35,
                    decoration: const BoxDecoration(
                        color: Color(0xffffb913),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 3,
                            blurRadius: 7,
                          )
                        ]),
                    //color: Colors.amber[700],
                    child: Column(children: [
                      TextFormField(
                        controller: loginEmailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: loginPasswordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_loginFormKey.currentState!.validate()) {
                              logInUser();

                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          child: const Text('EatUp'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //StudentLoginPage().deactivate();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StudentRegistrationPage().build(context)));
                        },
                        child: Text("Go to Register"),
                      ),
                      GestureDetector(
                        onTap: () {
                          //StudentLoginPage().deactivate();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantLogin().build(context)));
                        },
                        child: Text("Restaurant Login"),
                      )
                    ])))));
  }
}

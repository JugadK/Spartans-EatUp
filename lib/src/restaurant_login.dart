import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/main.dart';
import 'package:spartans_eatup/src/home_page.dart';
import 'package:spartans_eatup/src/restaurant_dashboard.dart';

class RestaurantLogin extends State<MyApp> {
  //TODO make this detect if user is a a restaurant or student user
  bool isLoggedInRestaurant = false;
  static final _restaurantFormKey = GlobalKey<FormState>();

  Future<void> logInUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: restaurantEmailController.text,
        password: restaurantPasswordController.text,
      );

      print(this.mounted);

      // changes page too Homepage is user logs in succesfully
      //StudentLoginPage().dispose();
      //StudentRegistrationPage().dispose();
      //RestaurantLogin().dispose();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Used in order to read values from Registration Form
  static TextEditingController restaurantEmailController =
      TextEditingController();
  static TextEditingController restaurantPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isLoggedInRestaurant == true) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RestaurantDashboard().build(context)));
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Code modified from from https://docs.flutter.dev/cookbook/forms/validation
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: Form(
                key: _restaurantFormKey,
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
                        controller: restaurantEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Restaurant Email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wrong Id';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: restaurantPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Restaurant Password",
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wrong Id';
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
                            if (_restaurantFormKey.currentState!.validate()) {
                              logInUser().then((value) => Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          RestaurantDashboard()
                                              .build(context))));

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
                          Navigator.pop(context);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //    builder: (context) =>
                          //       StudentLoginPage().build(context)));
                        },
                        child: Text("Go to Login"),
                      )
                    ])))));
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spartans_eatup/main.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/restaurant.dart';
import 'package:spartans_eatup/src/models/student.dart';

class RestaurantEditMenu extends StatefulWidget {
  final String restaurantName;
  const RestaurantEditMenu({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _RestaurantEditMenu createState() => _RestaurantEditMenu();
}

class _RestaurantEditMenu extends State<RestaurantEditMenu> {
  bool attemptedGetMenuFromDatabase = false;
  bool gotOrdersFromDatabase = false;

  List<String> filterTags = [];

  String currentFilterTag = "popular";

  List<Order>? menuOrders = [];
  List<Widget> menuWidgets = [];
  List<Widget> currentMenu = [];

  static final _editMenuNameFormKey = GlobalKey<FormState>();
  static final _editMenuPriceFormKey = GlobalKey<FormState>();

  static TextEditingController editMenuPriceEmailController =
      TextEditingController();

  static TextEditingController editMenuNameEmailController =
      TextEditingController();

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  Future<void> writeOrders(List<Order>? menu) async {
    List<dynamic> order = [];
    for (var element in menu!) {
      order.add(element.toJson());
    }

    await sendOrderToRestaurant();

    print(order);
    await restaurants
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .update({"menu": order})
        .then((value) => print("menu array changed"))
        .catchError((error) => print("Failed to merge data: $error"));
    setState(() {});
  }

  // Retrieves the menu from firebase and turns it into widgets we can
  // display
  Future<List<Order>> getMenu(String restaurantName) async {
    DocumentSnapshot restaurantSnapshot = await restaurants
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    print(FirebaseAuth.instance.currentUser!.uid.toString());

    Restaurant restaurant =
        Restaurant.fromJson(restaurantSnapshot.data() as Map<String, dynamic>);

    List<Order> menu = [];
    List<String> responseFilters = [];

    QuerySnapshot snapshot =
        await restaurants.where('name', isEqualTo: widget.restaurantName).get();

    const IconData close = IconData(0xe16a, fontFamily: 'MaterialIcons');

    if (snapshot.docs.isNotEmpty) {
      List<dynamic> responseJson = snapshot.docs.first.get("menu");
      for (var element in responseJson) {
        menu.add(Order.fromJson(element));
        menu.last.tags.forEach((tag) {
          if (!responseFilters.contains(tag)) {
            responseFilters.add(tag);
          }
        });
      }
    } else {
      print("Restaurant Name does not exist");
    }
    return menu;
    // setState(() {
    //   menuWidgets = menuData;
    // });
  }

  Future<void> sendOrderToRestaurant() async {
    QuerySnapshot snapshot = await restaurants
        .where('name', isEqualTo: widget.restaurantName)
        .where('currentOrderUsers',
            whereNotIn: [FirebaseAuth.instance.currentUser!.uid]).get();

    print("pfkladf");
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        element.reference.update({
          "currentOrderUsers":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    } else {
      print("User already has order in restaurant");
    }
  }

  // Code modified from https://firebase.flutter.dev/docs/firestore/usage/
  // If rehauled please remove
  Widget build(BuildContext context) {
    if (menuWidgets.isEmpty && !attemptedGetMenuFromDatabase) {
      print("hello");
      getMenu(widget.restaurantName);
      attemptedGetMenuFromDatabase = true;
    }

    // students.doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),
    return FutureBuilder<List<Order>>(
        future: getMenu(widget.restaurantName),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            menuOrders = snapshot.data;
            return Container(
                color: Color(0xFFFFFFFF),
                child: Column(
                  children: [
                    //  Container(
                    // height: 140,

                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 80),
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xff663eb6),
                      child: Text(widget.restaurantName,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFFFFFFFF),
                          )),
                    ),
                    Container(
                      height: 10,
                    ),

                    Expanded(
                        child: Material(
                            child: GridView.count(
                      //padding: const EdgeInsets.all(1),
                      primary: false,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      children: menuOrders!.map((element) {
                        return Column(children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 5, left: 110),
                              child: (() {
                                // Red X button to disable menu item
                                if (element.onCurrentMenu) {
                                  return GestureDetector(
                                      onTap: () => showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Disable Item'),
                                              content: const Text(
                                                  'Doing this will disable the item, meaning no new orders of this item will be created'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    element.onCurrentMenu =
                                                        false;
                                                    writeOrders(menuOrders);
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          ),
                                      child: CircleAvatar(
                                        child: const Icon(IconData(0xe16a,
                                            fontFamily: 'MaterialIcons')),
                                        radius: 15,
                                        backgroundColor: Colors.red[900],
                                      ));
                                  // Green Button to re enable menu item
                                } else {
                                  return GestureDetector(
                                      onTap: () => showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Enable Item'),
                                              content: const Text(
                                                  'Doing this will Enable  the item, meaning new orders of this item will be able to be created by customerss'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    element.onCurrentMenu =
                                                        true;
                                                    writeOrders(menuOrders);
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          ),
                                      child: CircleAvatar(
                                        child: const Icon(IconData(0xe156,
                                            fontFamily: 'MaterialIcons')),
                                        radius: 15,
                                        backgroundColor: Colors.green[900],
                                      ));
                                }
                              }())),
                          Container(
                              child: GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Edit Values'),
                                content: Column(
                                  children: [
                                    Form(
                                      key: _editMenuNameFormKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Name"),
                                            controller:
                                                editMenuNameEmailController,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                element.name =
                                                    editMenuNameEmailController
                                                        .text
                                                        .toString();

                                                writeOrders(menuOrders);
                                              },
                                              child: Text("Submit"))
                                        ],
                                      ),
                                    ),
                                    Form(
                                      key: _editMenuPriceFormKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Price"),
                                            controller:
                                                editMenuPriceEmailController,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                element.price = Decimal.parse(
                                                    editMenuPriceEmailController
                                                        .text);
                                                writeOrders(menuOrders);
                                              },
                                              child: Text("Submit"))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      element.onCurrentMenu = false;
                                      writeOrders(menuOrders);
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(element.picture),
                            ),
                          )),
                          Container(
                              height: 20,
                              child: Text(
                                element.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff000000),
                                ),
                              ))
                        ]);
                      }).toList(),
                      crossAxisCount: 2,
                    )))
                  ],
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

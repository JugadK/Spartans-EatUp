import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spartans_eatup/main.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spartans_eatup/src/models/order.dart';
import 'package:spartans_eatup/src/models/student.dart';

class RestaurantMenu extends StatefulWidget {
  final String restaurantName;
  const RestaurantMenu({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _RestaurantMenu createState() => _RestaurantMenu();
}

class _RestaurantMenu extends State<RestaurantMenu> {
  List<Widget> menuWidgets = [];
  List<Widget> currentOrders = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  Future<void> writeOrders(List<Order> orders) async {
    List<dynamic> order = [];
    for (var element in orders) {
      order.add(element.toJson());
    }

    await sendOrderToRestaurant();

    print(order);
    return students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .update({"orders": order})
        .then((value) => print("orders array changed"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  Future<void> getCurrentOrders() async {
    List<Widget> orders = [];
    DocumentSnapshot studentSnapshot = await students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    Student student =
        Student.fromJson(studentSnapshot.data() as Map<String, dynamic>);

    print(student.orders);

    student.orders.forEach((element) {
      orders.add(
        Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              //padding: const EdgeInsets.only(left: 20, top: 145),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.name + " " + element.price.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
    setState(() {
      currentOrders = orders;
    });
  }

  void addOrderWidget(Order order) {
    currentOrders.add(
      Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Container(
            //padding: const EdgeInsets.only(left: 20, top: 145),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.name + " " + order.price.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ],
            ),
          )),
    );

    setState(() {
      currentOrders = currentOrders;
    });
  }

  Future<void> getMenu(String restaurantName) async {
    DocumentSnapshot studentSnapshot = await students
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    print(studentSnapshot.data());
    Student student =
        Student.fromJson(studentSnapshot.data() as Map<String, dynamic>);
    List<Widget> menuData = [];
    List<Order> menu = [];
    QuerySnapshot snapshot =
        await restaurants.where('name', isEqualTo: widget.restaurantName).get();

    if (snapshot.docs.isNotEmpty) {
      List<dynamic> responseJson = snapshot.docs.first.get("menu");
      for (var element in responseJson) {
        menu.add(Order.fromJson(element));
      }

      menu.forEach((element) {
        menuData.add(ElevatedButton(
          child: Text("Add " + element.name + " \$" + element.price.toString()),
          onPressed: () {
            student.orders.add(element);
            addOrderWidget(element);
          },
        ));
      });

      //  menu.add(Order.fromJson(element))
    } else {
      print("Restaurant Name does not exist");
    }

    menuData.add(ElevatedButton(
      child: Text("Remove Last Order"),
      onPressed: () {
        if (student.orders.isEmpty) {
        } else {
          student.orders.removeLast();
          currentOrders.removeLast();
        }
        setState(() {
          currentOrders = currentOrders;
        });
      },
    ));

    menuData.add(ElevatedButton(
        onPressed: () {
          writeOrders(student.orders);
        },
        child: Text("Apply Changes")));

    setState(() {
      menuWidgets = menuData;
    });
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
    bool gotOrdersFromDatabase = false;
    if (menuWidgets.isEmpty) {
      getMenu(widget.restaurantName);
    }
    // This is so we can tell the differene between the user
    // removing all thier orders and the the data base having no orders stored
    if (currentOrders.isEmpty && !gotOrdersFromDatabase) {
      getCurrentOrders();
      gotOrdersFromDatabase = true;
    }

    // students.doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),

    return Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        color: Color(0xffFFFFFF),
        child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: currentOrders,
          ),

          Column(children: menuWidgets),
          //Text(student.orders.toString()),

          /*
                ElevatedButton(
                    onPressed: () {
                      //
                      // Here we add the order to the array orders
                      // This will be used for telling the restaurant what to m
                      // make
                      //
                      // we can manipulate this student object
                      // before we actually write to the database, letting the
                      // UI add and remove orders before writing
                      //

                      student.orders.add(Order(
                          name: "Rice",
                          price: Decimal.parse("22.99"),
                          restaurant: "Amogus"));

                      //
                      // writeOrders will actually write the orders to the database
                      // this will only change the orders array
                      //

                      writeOrders(student.orders);
                      print(student.orders);
                    },
                    
                    child: Text("Rice")),*/
        ])));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartans_eatup/src/constants.dart';
import 'colors.dart' as color;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> allRestaurants = [];
  List<String> responseList = [];
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  List<Widget> itemsData = [];

  void getPostData(String query) async {
    responseList = [];
    QuerySnapshot snapshot = await restaurants.get();
    print(snapshot);
    snapshot.docs.forEach((element) {
      allRestaurants.add(element.get("name").toString());
    });

    filterPostData(query);
  }

  void filterPostData(String query) async {
    responseList = [];

    if (query == "") {
      allRestaurants.forEach((element) {
        responseList.add(element);
      });
    } else {
      allRestaurants.forEach((element) {
        String name = element;
        // Checks if first few letters match any names in our db, checks for
        // case insensitive
        if (name.substring(0, query.length).toLowerCase() ==
            query.toLowerCase()) {
          responseList.add(element);
        }
      });
    }
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(const SizedBox(height: 10));
      listItems.add(
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
              padding: const EdgeInsets.only(left: 20, top: 145),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post,
                    style: const TextStyle(
                      fontSize: 30,
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
      itemsData = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allRestaurants.isEmpty) {
      getPostData("");
    }

    return Scaffold(
        backgroundColor: color.AppColor.white,
        body: Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xffF6B92E),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CupertinoSearchTextField(
                    onSubmitted: (value) {
                      filterPostData(value);
                    },
                  ),
                  Column(
                    children: itemsData.map((e) {
                      return e;
                    }).toList(),
                  )
                ],
              ),
            )));
  }
}

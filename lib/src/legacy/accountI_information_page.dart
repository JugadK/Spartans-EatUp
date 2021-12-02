import 'package:flutter/material.dart';

class account_information_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Personal Information'),
          ),
          body: AccountInformationPage()),
    );
  }
}

// User Image
class UserImage extends StatelessWidget {
  String userImageNetAddress =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdY7ZnfmmnbxVs6ybjliqGVXZImGk-r1p7zg&usqp=CAU';
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150.0,
      height: 150.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(150),
          image: DecorationImage(
              image: NetworkImage(userImageNetAddress), fit: BoxFit.cover)),
    );

    // ClipOval(
    //   child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaop8V4VQ_jDcxodOxphRC-legIoLtqkLjkQ&usqp=CAU',
    //   width: 175.0,
    //   height: 175.0,
    //   ),
  }
}

// element position setting

class AccountInformationPage extends StatelessWidget {
  double height = 790.0;
  double width = 410.0;
  String username = 'Sammy the Spartan';
  String userID = 'xxxxxxxx';
  String studentEmail = 'StudentEmail@sjsu.edu';
  String phoneNumPart1 = '510';
  String phoneNumPart2 = '123';
  String phoneNumPart3 = '4567';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      heightFactor: height,
      widthFactor: width,
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            // Hi spartan text
            Positioned(
              child: Text(
                'Hi,Spartan',
                style: TextStyle(
                    fontSize: 39,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent),
              ),
            ),

            // user image
            Positioned(top: 25, left: 130, child: UserImage()),

            // Name  title
            Positioned(
                top: 275,
                right: 330,
                child: Text('Name',
                    style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 18))),

            // Student ID  title

            Positioned(
              child: Text(
                'Student ID',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
              ),
              top: 275,
              right: 60,
            ),

            // UserName
            Positioned(
              child: Text(
                this.username,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              top: 315,
              right: 250,
            ),

            //user Student ID
            Positioned(
              child: Text(
                this.userID,
                style: TextStyle(color: Colors.black),
              ),
              top: 315,
              right: 90,
            ),

            // __________

            Positioned(
              child: Text(
                "__________________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 325,
              right: 50,
            ),

            // Email title
            Positioned(
              child: Text('Email',
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 18)),
              top: 355,
              right: 333,
            ),

            // user Email
            Positioned(
              child: Text(
                studentEmail,
                style: TextStyle(color: Colors.black),
              ),
              top: 395,
              right: 225,
            ),

            // __________
            Positioned(
              child: Text(
                "__________________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 405,
              right: 50,
            ),

            //Number title
            Positioned(
              child: Text(
                'Number',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
              ),
              top: 435,
              right: 310,
            ),

            Positioned(
              child: Text(
                '+1($phoneNumPart1) $phoneNumPart2 - $phoneNumPart3',
                style: TextStyle(color: Colors.black),
              ),
              top: 475,
              right: 250,
            ),

            // __________

            Positioned(
              child: Text(
                "__________________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 485,
              right: 50,
            ),

            // Account Settings

            Positioned(
              child: Text(
                'Account Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              top: 520,
              right: 167,
            ),

            // change paymenthod

            Positioned(
              child: Text('Change payment method'),
              top: 570,
              right: 190,
            ),

            // Navigate_next Icon
            Positioned(
              child: Icon(
                Icons.navigate_next,
                color: Colors.grey,
                size: 35,
              ),
              top: 565,
              right: 45,
            ),

            // __________

            Positioned(
              child: Text(
                "_______________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 580,
              right: 50,
            ),

            // Past orders
            Positioned(
              child: Text('Past Orders'),
              top: 610,
              right: 280,
            ),

            // __________

            Positioned(
              child: Text(
                "_______________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 620,
              right: 50,
            ),

            // Navigate_next Icon
            Positioned(
              child: Icon(
                Icons.navigate_next,
                color: Colors.grey,
                size: 35,
              ),
              top: 605,
              right: 45,
            ),
            //log out
            Positioned(
              child: Text('Log Out'),
              top: 650,
              right: 305,
            ),

            // __________

            Positioned(
              child: Text(
                "_______________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 660,
              right: 50,
            ),

            // Navigate_next Icon
            Positioned(
              child: Icon(
                Icons.navigate_next,
                color: Colors.grey,
                size: 35,
              ),
              top: 645,
              right: 45,
            ),

            // __________

            Positioned(
              child: Text(
                "____________________________________________________",
                style: TextStyle(color: Colors.grey),
              ),
              top: 700,
              right: 0,
            ),

            Positioned(
              child: Icon(
                Icons.home,
                size: 50,
              ),
              top: 720,
              left: 50,
            ),

            Positioned(
              child: Icon(
                Icons.search,
                size: 50,
              ),
              top: 720,
              left: 180,
            ),

            Positioned(
              child: Icon(
                Icons.shopping_bag,
                size: 50,
              ),
              top: 720,
              left: 310,
            )
          ],
        ),
      ),
    );
  }
}

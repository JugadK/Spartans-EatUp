import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'payment_page.dart';
import 'account_info.dart';

class MyCard extends StatefulWidget {
  MyCard({Key? key}) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}






class _MyCardState extends State<MyCard> {
  String cardNumber = '1111 3333 2222 111';
  String expiryDate = '02/21';
  String cardHolderName = 'TEAM 6';
  String cvvCode = '133';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My  Card',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(appBar: AppBar(title: Text('My Card',style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.lightBlue,
      leading: IconButton(icon: Icon(Icons.navigate_before),
      onPressed: (){
        Navigator.push(context,
         MaterialPageRoute(builder: (context) => Account(),fullscreenDialog: true ));
      },
      ),
      ),
        body: Container(
          color: Colors.white,
          child: Column(children: <Widget>[
            
            SizedBox(height: 5,width: 5,),
            
            CreditCardWidget(
              cardNumber: cardNumber, 
            expiryDate: expiryDate, 
            cardHolderName: cardHolderName, 
            cvvCode: cvvCode, 
            showBackView: isCvvFocused, 
            onCreditCardWidgetChange: (p0) {
              
            }, 
            obscureCardNumber: true,
            isHolderNameVisible: true,
            ),
            CreditCardWidget(
              cardNumber: cardNumber, 
            expiryDate: expiryDate, 
            cardHolderName: 'CMPE 133', 
            cvvCode: cvvCode, 
            showBackView: isCvvFocused, 
            onCreditCardWidgetChange: (p0) {
              
            }, 
            obscureCardNumber: true,
            isHolderNameVisible: true,
            ),

            SizedBox(height: 100,width: 100,),

            TextButton(onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> PaymentPage(),fullscreenDialog: true));
            }, 
            child: Text('Try to Pay'))
            

            
          ],),)
          ,),
    );
  }
}
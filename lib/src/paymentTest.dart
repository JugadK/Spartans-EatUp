// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;


class MyPaymentScreen extends StatefulWidget {
  MyPaymentScreen({Key? key}) : super(key: key);

  @override
  _MyPaymentScreenState createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<MyPaymentScreen> {


  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              await makePayment();
            },
            child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.lightGreen
            ),
            child: Center(
              child: Text('Check out ') ,
              ),
          ),
          )
          
          ],
      ),
    );
  }


  Future<void> makePayment() async{
    try{
      paymentIntentData = await createPaymentInter('20','USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          merchantCountryCode: 'US',
          merchantDisplayName: 'ASIF'
        )
        );


        displayPaymentShee();

    }catch(e){
      print('Ececption' + e.toString());
    }
  }

  

  displayPaymentShee() async{
    try{
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData!['client_secret'],
          confirmPayment: true
          )
      );
      setState(() {
        paymentIntentData = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Paid successfully')));


    }on StripeException catch(e){
      print(e.toString());

      
      showDialog(
        context: context, 
        builder: (_)=> AlertDialog(
          content: Text('Cancelled'),
        ));
    }
  }




  createPaymentInter(String amount, String currency) async{
    try{
      
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency':currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
      body: body,
      headers: {
        'Authorization': 'sk_test_51K5NamGDzLzRh3WogH4j8WyL7WCUGQMf51l3FuPIn7oavmuUuELzlXKJdImr9pkOpPCsBh10F1J2rUvxtCZo4jPm00ALwwkjsY',
        'Content-Type': 'application/x-www-form-urlencoded'
      }
      
      );
      
      return jsonDecode(response.body.toString());
      



    }catch(e){
      print('Ececption' + e.toString());
    }
  }

  calculateAmount(String amount){
    final price = int.parse(amount) * 100;
    return price.toString();
  }





}


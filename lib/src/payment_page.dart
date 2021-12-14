import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'my_card.dart';


class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (title: Text('Payment Page'),
      leading: IconButton(icon: Icon(Icons.navigate_before),
      onPressed: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => MyCard()));
      },
      ),
      ),
      body: Column(children: [
        SizedBox(height:600,width: 150,),
          Container(
          child: Center(
            child: Text('Amount: 10 \$',style:TextStyle(fontSize: 22),)
            ),),
          SizedBox(height: 20,width: 20,),
        //   CardField(
        //   onCardChanged: (card) {
        //     print(card);
        //   },
        // ),
        TextButton(
          onPressed: () async {
            final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
          },
          child: InkWell(
          onTap: ()async{
            await makePayment();
          },
          child: Container(
            height: 50,
            width: 200,
            child: Center(
              child: Container(
                child: Text('Pay',style: TextStyle(fontSize: 30,color: Colors.black),
                
                ),
                color: Colors.green,
                ),
            ),
          ),
        ),
        ),
        SizedBox(height: 50,width: 200,),
        
          
      ],),
    );
  }
  Future<void> makePayment() async {
    try {

      paymentIntentData =
      await createPaymentIntent('10', 'USD'); 
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'CMPE-133 Testing')).then((value){
      });
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: false,
          )).then((newValue){


        print('payment intent'+paymentIntentData!['id'].toString());
        print('payment intent'+paymentIntentData!['client_secret'].toString());
        print('payment intent'+paymentIntentData!['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('10'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51K5NamGDzLzRh3WogH4j8WyL7WCUGQMf51l3FuPIn7oavmuUuELzlXKJdImr9pkOpPCsBh10F1J2rUvxtCZo4jPm00ALwwkjsY',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }
}
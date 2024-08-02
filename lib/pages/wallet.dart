// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:app/service/database.dart';
import 'package:app/service/shared_pref.dart';
import 'package:app/widget/app_constant.dart';
import 'package:app/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController amountcontroller = TextEditingController();

  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 70.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                      elevation: 2.0,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Center(
                            child: Text(
                          'Wallet',
                          style: AppWidget.headlinetext(),
                        )),
                      )),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/wallet.png',
                          height: 60.0,
                          width: 60.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 40.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Wallet',
                              style: AppWidget.lighttext(),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '\$${wallet!}',
                              style: AppWidget.boldtext(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Add Money',
                      style: AppWidget.semiboldtext(),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            makePayment("100");
                          },
                          child: Text(
                            '\$100',
                            style: AppWidget.boldtext(),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            makePayment("200");
                          },
                          child: Text(
                            '\$200',
                            style: AppWidget.boldtext(),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            makePayment("400");
                          },
                          child: Text(
                            '\$400',
                            style: AppWidget.boldtext(),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            makePayment("1000");
                          },
                          child: Text(
                            '\$1000',
                            style: AppWidget.boldtext(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        openEdit();
                      },
                      child: const Text('Add Money',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold)),
                    )),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Azeddin'))
          .then((value) {});

      //display payment sheeet
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    add = int.parse(wallet!) + int.parse(amount);
    await SharedPreferenceHelper().saveUserWallet(add.toString());
    await DatabaseMethodes().updateUserWallet(id!, add.toString());
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Payment Successfull"),
                    ],
                  ),
                ));
        getthesharedpref();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;

    return calculatedAmout.toString();
  }

  Future openEdit() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel)),
                    const SizedBox(
                      width: 60.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text("Amount"),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Enter Amount'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      makePayment(amountcontroller.text);
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Add Money",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

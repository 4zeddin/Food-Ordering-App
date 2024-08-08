import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/service/database.dart';
import 'package:app/service/shared_pref.dart';
import 'package:app/widget/widget_support.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String? id, wallet;
  int total = 0;
  int amount2 = 0;

  Stream<QuerySnapshot>? foodStream; // Nullable Stream

  void startTimer() {
    Timer(const Duration(seconds: 1), () {
      amount2 = total;
      setState(() {});
    });
  }

  Future<void> getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    if (id != null) {
      // Await the future to get the stream
      foodStream = await DatabaseMethodes().getFoodCart(id!);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref(); // Initialize shared preferences and foodStream
    startTimer();
  }

  Future<void> _handleCheckout() async {
    if (wallet != null && id != null) {
      try {
        // Log the current wallet value
        print("Current wallet: '$wallet'");

        // Attempt to parse the wallet amount as double
        double walletAmount;
        try {
          walletAmount = double.parse(wallet!);
        } catch (e) {
          print("Error parsing wallet amount: $e");
          return;
        }

        // Convert walletAmount to int if needed
        int walletAmountInt = walletAmount.toInt();
        print("Parsed wallet amount: $walletAmountInt");

        // Check if the wallet amount is greater than or equal to the total amount
        if (walletAmountInt < total) {
          // Show error message if not enough funds
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Insufficient funds. Please add more money to your wallet.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Show confirmation dialog
        bool confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Checkout'),
            content: Text(
                'Are you sure you want to checkout? Total amount: \$${total.toString()}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          ),
        );

        if (confirmed) {
          // Calculate the new wallet amount
          int amount = walletAmountInt - total;
          print("Calculated amount: $amount");

          // Update the wallet in the database
          await DatabaseMethodes().updateUserWallet(id!, amount.toString());
          print("Database update complete");

          // Update the wallet in shared preferences
          await SharedPreferenceHelper().saveUserWallet(amount.toString());
          print("Shared preferences update complete");

          // Navigate to the home screen
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      } catch (e) {
        print("Error during checkout: $e");
      }
    } else {
      print("Wallet or ID is null");
    }
  }

  Widget foodCart() {
    return StreamBuilder<QuerySnapshot>(
      stream: foodStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No items in cart.'));
        }

        List<DocumentSnapshot> docs = snapshot.data!.docs;
        total = docs.fold(0, (sum, doc) => sum + int.parse(doc["Total"]));

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = docs[index];
            return Container(
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text(ds["Quantity"])),
                      ),
                      const SizedBox(width: 20.0),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CachedNetworkImage(
                            imageUrl: ds["Image"],
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ds["Name"], style: AppWidget.semiboldtext()),
                          Text("\$" + ds["Total"],
                              style: AppWidget.semiboldtext())
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                      "Food Cart",
                      style: AppWidget.headlinetext(),
                    )))),
            const SizedBox(height: 20.0),
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: foodCart()),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price", style: AppWidget.boldtext()),
                  Text("\$" + total.toString(), style: AppWidget.semiboldtext())
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _handleCheckout, // Use the new checkout handler
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: const Center(
                    child: Text(
                  "CheckOut",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

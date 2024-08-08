import 'dart:async';
import 'package:app/admin/add_items.dart';
import 'package:app/admin/admin_login.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/auth/forgotpassword.dart';
import 'package:app/pages/auth/login.dart';
import 'package:app/pages/auth/onboard.dart';
import 'package:app/pages/auth/singup.dart';
import 'package:app/pages/buttomnav.dart';
import 'package:app/pages/order.dart';
import 'package:app/pages/home.dart';
import 'package:app/widget/app_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = publishablekey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // title: 'Food app',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: LogIn(),
    );
  }
}

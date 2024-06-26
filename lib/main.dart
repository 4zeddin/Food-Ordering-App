import 'dart:async';
import 'package:app/firebase_options.dart';
import 'package:app/pages/auth_ui/forgotpassword.dart';
import 'package:app/pages/auth_ui/login.dart';
import 'package:app/pages/auth_ui/onboard.dart';
import 'package:app/pages/auth_ui/singup.dart';
import 'package:app/pages/buttomnav.dart';
import 'package:app/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SingUp(),
    );
  }
}

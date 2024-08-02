import 'package:app/pages/auth/login.dart';
import 'package:app/pages/buttomnav.dart';
import 'package:app/service/database.dart';
import 'package:app/service/shared_pref.dart';
import 'package:app/widget/content_model.dart';
import 'package:app/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  String name = "", email = "", password = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> registration() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Register Successfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ButtomNav()));

      // Push to DB
      String id = randomAlphaNumeric(10);
      Map<String, dynamic> addUserInfo = {
        "Name": namecontroller.text,
        "Email": emailcontroller.text,
        "wallet": "0",
        "Id": id
      };
      await DatabaseMethodes().addUserDetail(addUserInfo, id);

      // Add to Shared Preferences
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserName(namecontroller.text);
      await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
      await SharedPreferenceHelper().saveUserWallet("0");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "The email address is already in use.",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error: ${e.message}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registration failed. Please try again.',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 204, 0, 0),
                  Color.fromARGB(255, 255, 102, 0),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 60, right: 22, left: 22),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      width: MediaQuery.of(context).size.width / 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              'Sign up',
                              style: AppWidget.headlinetext(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: namecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please Enter name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.person_outline),
                                hintText: 'Name',
                                hintStyle: AppWidget.semiboldtext(),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please Enter Email';
                                }
                                return null;
                              },
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.email_outlined),
                                hintText: 'Email',
                                hintStyle: AppWidget.semiboldtext(),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please Enter Password';
                                }
                                return null;
                              },
                              controller: passwordcontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.password_outlined),
                                hintText: 'Password',
                                hintStyle: AppWidget.semiboldtext(),
                              ),
                            ),
                            const SizedBox(height: 70),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 204, 0, 0),
                                      Color.fromARGB(255, 255, 102, 0),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formkey.currentState!.validate()) {
                                        email = emailcontroller.text;
                                        password = passwordcontroller.text;
                                        name = namecontroller.text;
                                        registration();
                                      }
                                    },
                                    child: const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogIn()),
                      );
                    },
                    child: Text(
                      'Already have an account? Sign in',
                      style: AppWidget.semiboldtext(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

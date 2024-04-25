import 'package:app/pages/auth_ui/forgotpassword.dart';
import 'package:app/pages/auth_ui/singup.dart';
import 'package:app/pages/buttomnav.dart';
import 'package:app/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  
  login() async {
    try{ await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Logged In Successfully",
      style: TextStyle(fontSize: 20),
    )));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ButtomNav()));
    }on FirebaseAuthException catch (e){
      if (e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "User Not Found",
          style: TextStyle(fontSize: 20),
        )));  
      } else if (e.code == "wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Password Incorrect",
          style: TextStyle(fontSize: 20),
        )));
      }
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
                              'Login',
                              style: AppWidget.headlinetext(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return "please enter field";
                                }else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.email_outlined),
                                hintText: 'Email',
                                hintStyle: AppWidget.semiboldtext(),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return "please enter field";
                                }else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.password_outlined),
                                hintText: 'Password',
                                hintStyle: AppWidget.semiboldtext(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'Forgot Password?',
                                  style: AppWidget.semiboldtext(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 70),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
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
                                        login();
                                      }
                                    },
                                    child: const Text(
                                      'LOGIN',
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
                  const SizedBox(height: 70),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SingUp()));
                    },
                    child: Text(
                      "Don't have an account? Sign up",
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

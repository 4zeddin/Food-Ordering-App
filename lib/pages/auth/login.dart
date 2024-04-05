import 'package:app/widget/widget_support.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                          TextField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.email_outlined),
                              hintText: 'Email',
                              hintStyle: AppWidget.semiboldtext(),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.password_outlined),
                              hintText: 'Password',
                              hintStyle: AppWidget.semiboldtext(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Forgot Password?',
                              style: AppWidget.semiboldtext(),
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
                              child: const Center(
                                child: Text(
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                          Text(
                            'Don\'t have an account? Sign up',
                            style: AppWidget.semiboldtext(),
                            textAlign: TextAlign.center,
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

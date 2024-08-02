import 'package:app/admin/add_items.dart';
import 'package:flutter/material.dart';
import 'package:app/widget/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Welcome to \nAdmin Panel",
                style: AppWidget.headlinetext(),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const AddFood()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 53, 51, 51),
                        Colors.black
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "images/food.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        const Text(
                          "Add Food Items",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

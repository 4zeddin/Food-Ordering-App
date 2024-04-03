import 'package:app/pages/details.dart';
import 'package:app/widget/widget_support.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ice = false, pizza = false, burger = false, salad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello User,",
                  style: AppWidget.boldtext(),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Delicious Food",
              style: AppWidget.headlinetext(),
            ),
            Text(
              "Descover and get Great Food",
              style: AppWidget.lighttext(),
            ),
            const SizedBox(
              height: 20,
            ),
            showItem(),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Details()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/salad2.png',
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Vigie Taco Hash',
                                style: AppWidget.semiboldtext(),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Fresh and Healthy',
                                style: AppWidget.lighttext(),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "\$25",
                                style: AppWidget.semiboldtext(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  // 2 card
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/salad2.png',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              'Vigie Taco Hash',
                              style: AppWidget.semiboldtext(),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Fresh and Healthy',
                              style: AppWidget.lighttext(),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "\$25",
                              style: AppWidget.semiboldtext(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  // 2 card end
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/salad2.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              'Medeteranian Ckeckpea Salad',
                              style: AppWidget.semiboldtext(),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              'Fresh and Healthy',
                              style: AppWidget.lighttext(),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "\$25",
                              style: AppWidget.semiboldtext(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              ice = true;
              pizza = false;
              burger = false;
              salad = false;
              setState(() {});
            },
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ice ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset('images/ice-cream.png',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                      color: ice ? Colors.white : Colors.black),
                )),
          ),
          GestureDetector(
            onTap: () {
              ice = false;
              pizza = true;
              burger = false;
              salad = false;
              setState(() {});
            },
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: pizza ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset('images/pizza.png',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                      color: pizza ? Colors.white : Colors.black),
                )),
          ),
          GestureDetector(
            onTap: () {
              ice = false;
              pizza = false;
              burger = false;
              salad = true;
              setState(() {});
            },
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: salad ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset('images/salad.png',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                      color: salad ? Colors.white : Colors.black),
                )),
          ),
          GestureDetector(
            onTap: () {
              ice = false;
              pizza = false;
              burger = true;
              salad = false;
              setState(() {});
            },
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: burger ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset('images/burger.png',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                      color: burger ? Colors.white : Colors.black),
                )),
          ),
        ],
      ),
    );
  }
}

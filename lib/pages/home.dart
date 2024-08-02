import 'package:app/pages/details.dart';
import 'package:app/pages/order.dart';
import 'package:app/service/database.dart';
import 'package:app/service/shared_pref.dart';
import 'package:app/widget/widget_support.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ice = false, pizza = false, burger = false, salad = false;
  String? username;
  Stream? fooditemStream;

  ontheload() async {
    username = await SharedPreferenceHelper().getUserName();
    fooditemStream = await DatabaseMethodes().getFoodItem("Salad");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    salad = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: 20,
        ),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  username != null ? "Hello $username 👋," : "Hello 👋,",
                  style: AppWidget.boldtext(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
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
            categoryList(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(height: 280, child: allItems()),
            const SizedBox(
              height: 20,
            ),
            allItemsVertical(),
          ],
        ),
      ),
    );
  }

  Widget categoryList() {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              ice = true;
              pizza = false;
              burger = false;
              salad = false;
              fooditemStream =
                  await DatabaseMethodes().getFoodItem("Ice-cream");
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
            onTap: () async {
              ice = false;
              pizza = true;
              burger = false;
              salad = false;
              fooditemStream = await DatabaseMethodes().getFoodItem("Pizza");
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
            onTap: () async {
              ice = false;
              pizza = false;
              burger = false;
              salad = true;
              fooditemStream = await DatabaseMethodes().getFoodItem("Salad");
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
            onTap: () async {
              ice = false;
              pizza = false;
              burger = true;
              salad = false;
              fooditemStream = await DatabaseMethodes().getFoodItem("Burger");
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

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                    image: ds['Image'],
                                    name: ds['Name'],
                                    price: ds['Price'],
                                    detail: ds['Detail'])));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        width: 200, // Set a fixed width for all cards
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 200,
                              maxWidth: 200,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                      imageUrl: ds['Image'],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    ds['Name'],
                                    style: AppWidget.semiboldtext(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Expanded(
                                    child: Text(
                                      ds['Detail'],
                                      style: AppWidget.lighttext(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines:
                                          2, // Limit the detail text to 2 lines
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "\$${ds['Price']}",
                                    style: AppWidget.semiboldtext(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget allItemsVertical() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                      image: ds['Image'],
                                      name: ds['Name'],
                                      detail: ds['Detail'],
                                      price: ds['Price'])));
                        },
                        child: Container(
                          margin:
                              const EdgeInsets.only(right: 20.0, bottom: 20),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      imageUrl: ds['Image'],
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          ds['Name'],
                                          style: AppWidget.semiboldtext(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          ds['Detail'],
                                          style: AppWidget.lighttext(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          '\$${ds["Price"]}',
                                          style: AppWidget.semiboldtext(),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  })
              : Container();
        });
  }
}

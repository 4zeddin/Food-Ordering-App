import 'package:app/service/database.dart';
import 'package:app/service/shared_pref.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/widget/widget_support.dart';
import 'package:flutter/widgets.dart';

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int n = 1, total = 0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    total = int.parse(widget.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
            Center(
              child: CachedNetworkImage(
                imageUrl:  widget.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 1.2,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: AppWidget.boldtext(),
                      ),
                      Text(
                        widget.detail,
                        overflow: TextOverflow.ellipsis,
                        style: AppWidget.boldtext(),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    ++n;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  n.toString(),
                  style: AppWidget.semiboldtext(),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    n > 1 ? --n : n;
                    total = total - int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Lorem aliquet risus feugiat in ante metus dictum at tempor commodo ullamcorper a lacus vestibulum sed arcu non odio euismod lacinia at quis risus sed vulputate odio ut enim',
              style: AppWidget.lighttext(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Delivery Time',
                  style: AppWidget.semiboldtext(),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                Text(
                  '30 min',
                  style: AppWidget.semiboldtext(),
                )
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: AppWidget.semiboldtext(),
                      ),
                      Text(
                        '\$${total.toString()}',
                        style: AppWidget.headlinetext(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodToCart = {
                        'Name': widget.name,
                        'Total': total.toString(),
                        'Image': widget.image,
                        'Quantity': n.toString()
                      };

                      await DatabaseMethodes().addFoodItem(addFoodToCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Item has been added Successfully to Cart",
                            style: TextStyle(fontSize: 18.0),
                          )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

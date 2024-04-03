import 'package:flutter/material.dart';
import 'package:app/widget/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
              child: Image.asset(
                'images/salad2.png',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vigie Taco Hash',
                      style: AppWidget.boldtext(),
                    ),
                    Text(
                      'Fresh and Healthy',
                      style: AppWidget.boldtext(),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20,),
                Text('1', style: AppWidget.semiboldtext(),),
                const SizedBox(width: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

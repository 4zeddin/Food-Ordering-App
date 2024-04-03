import 'package:app/pages/home.dart';
import 'package:app/pages/order.dart';
import 'package:app/pages/profile.dart';
import 'package:app/pages/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ButtomNav extends StatefulWidget {
  const ButtomNav({super.key});

  @override
  State<ButtomNav> createState() => _ButtomNavState();
}

class _ButtomNavState extends State<ButtomNav> {
  int currentPageIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Order order;
  late Wallet wallet;
  late Profile profile;
  @override
  void initState() {
    homepage = const Home();
    order = const Order();
    wallet = const Wallet();
    profile = const Profile();
    pages = [homepage, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            CurvedNavigationBar(
              height: 65.0,
              backgroundColor: Colors.white,
              color: Colors.black,
              animationDuration: const Duration(milliseconds: 500),
              onTap: (int index){setState(() {
                currentPageIndex = index;
              });},
              items: const [
                Icon(Icons.home_outlined,color: Colors.white,),
                Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                Icon(Icons.wallet_outlined,color: Colors.white,),
                Icon(Icons.person_outlined,color: Colors.white,),
            ]),
        body: pages[currentPageIndex],
     );
  }
}

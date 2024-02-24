import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';
// import 'package:markclone/Functionalities/special_functions.dart';
// import 'package:markclone/Functionalities/special_functions.dart';
import 'package:markclone/constants/colors.dart';
import 'package:markclone/screens/home/account.dart';
import 'package:markclone/screens/home/cart.dart';
import 'package:markclone/screens/home/categories.dart';
import 'package:markclone/screens/home/help.dart';
import 'package:markclone/screens/home/trend.dart';
import 'package:markclone/special_ui_elements/animation_visuals.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int currentIndex = 0;

  //home pages
  late List<Widget> _pages;
  final List<String> _titles = ['', 'Trending', 'Settings', 'Support'];

  @override
  void initState() {
    super.initState();
    _pages = const [Categories(), Trending(), Account(), Help()]; //home pages
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimension = getScreenDimensions(context);
    return SafeArea(
      child: Scaffold(
        body: _pages[currentIndex],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          leading: Image.asset(
            'assets/images/splash_image.png',
            color: Colors.white,
          ),
          actions: [
            Text(
              _titles[currentIndex],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenDimension['width']! * 0.05),
            ),
            SizedBox(
              width: screenDimension['width']! * 0.3,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/search'); //search page
                },
                splashColor: Colors.black,
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                  size: 30.0,
                )),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(customPageRoute(const Cart())); //cart page
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 30.0,
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: CustomColors.primaryColor,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            elevation: 12.0,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              }); //select tapped button
            },
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                  label: 'Home', icon: Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  label: 'Trending', icon: Icon(Icons.trending_down_outlined)),
              BottomNavigationBarItem(
                  label: 'Settings', icon: Icon(Icons.settings)),
              BottomNavigationBarItem(label: 'Support', icon: Icon(Icons.help)),
            ]),
      ),
    );
  }
}

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

PageController pageController = new PageController();

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    Home(),
    ShopBuy(),
    ShoppingCart(),
    Favourite(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    // update page controller from start if needed
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Common.scaffoldKey,
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: AppColors.appBlueColor,
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: AppColors.appWhiteColor,
            inactiveColor: Colors.blue,
            title: Text(
              'Home',
              textAlign: TextAlign.center,
            ),
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavyBarItem(
            activeColor: AppColors.appWhiteColor,
            inactiveColor: Colors.blue,
            title: Text(
              'Shop',
              textAlign: TextAlign.center,
            ),
            icon: Icon(Icons.add_business),
          ),
          BottomNavyBarItem(
            activeColor: AppColors.appWhiteColor,
            inactiveColor: Colors.blue,
            title: Text(
              "Cart",
              textAlign: TextAlign.center,
            ),
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavyBarItem(
            activeColor: AppColors.appWhiteColor,
            inactiveColor: Colors.blue,
            title: Text(
              'Wishlist',
              textAlign: TextAlign.center,
            ),
            icon: Icon(Icons.favorite),
          ),
          BottomNavyBarItem(
            activeColor: AppColors.appWhiteColor,
            inactiveColor: Colors.blue,
            title: Text(
              'Profile',
              textAlign: TextAlign.center,
            ),
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
      ),
    );
  }
}

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';
import 'package:badges/badges.dart';

import '../cart_provider.dart';

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
    getCart();
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
    return Consumer<CartProvider>(builder: (context, i, _) {
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
                style: GoogleFonts.montserrat(),
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
                'Shop',style: GoogleFonts.montserrat(),
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.add_business),
            ),
            BottomNavyBarItem(
                activeColor: AppColors.appWhiteColor,
                inactiveColor: Colors.blue,
                title: Text(
                  "Cart",style: GoogleFonts.montserrat(),
                  textAlign: TextAlign.center,
                ),
                icon: Container(
                  child: Badge(
                    position: BadgePosition.topEnd(top: -10, end: -5),
                    badgeColor: Colors.deepOrange,
                    showBadge: true,
                    badgeContent: Text('${i.cartCount}',
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    child: Icon(Icons.shopping_cart),
                  ),
                )),
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                'Wishlist',style: GoogleFonts.montserrat(),
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.favorite),
            ),
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                'Profile',style: GoogleFonts.montserrat(),
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.account_circle_rounded),
            ),
          ],
        ),
      );
    });
  }

  Future<void> getCart() async {
    await Provider.of<CartProvider>(context, listen: false)
        .getCartProducts(context);
  }
}

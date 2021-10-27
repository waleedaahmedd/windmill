import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import 'views/routes/app_routes.dart';

void main() async {
  await Common.licensesFonts();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${Common.applicationName}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.appWhiteColor,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      initialRoute: AppRoutes.dashboardRoute,
      routes: {
        AppRoutes.getStartedRoute: (context) => GetStarted(),
        AppRoutes.loginRoute: (context) => Login(),
        AppRoutes.registerRoute: (context) => Register(),
        AppRoutes.forgetPasswordRoute: (context) => ForgetPassword(),
        AppRoutes.chooseOptionRoute: (context) => ChooseOption(),
        AppRoutes.dashboardRoute: (context) => Dashboard(),
        AppRoutes.shopBuyRoute: (context) => ShopBuy(),
        AppRoutes.shoppingCartRoute: (context) => ShoppingCart(),
        AppRoutes.ordersRoute: (context) => Orders(),
        AppRoutes.contactUsRoute: (context) => ContactUs(),
        AppRoutes.productDetailRoute: (context) => ProductDetail(),
      },
    );
  }
}

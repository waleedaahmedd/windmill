import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:windmill_general_trading/views/edit_profile.dart';
import 'package:windmill_general_trading/views/notification.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/verification_screen.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import 'views/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Common.licensesFonts();
  await GetStorage.init();
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
      initialRoute: AppRoutes.verificationRoute,
      routes: {
        AppRoutes.verificationRoute: (context) => VerificationScreen(),

        AppRoutes.getStartedRoute: (context) => GetStarted(),

        AppRoutes.loginRoute: (context) => Login(),
        AppRoutes.registerRoute: (context) => Register(),
        AppRoutes.forgetPasswordRoute: (context) => ForgetPassword(),
        AppRoutes.chooseOptionRoute: (context) => ChooseOption(),
        AppRoutes.dashboardRoute: (context) => Dashboard(),
        AppRoutes.shopBuyRoute: (context) => ShopBuy(),
        AppRoutes.shoppingCartRoute: (context) => ShoppingCart(),
        AppRoutes.ordersRoute: (context) => Orders(),
        AppRoutes.storeLocatorRoute: (context) => StoreLocator(),
        AppRoutes.editProfileRoute: (context) => EditProfile(),
        AppRoutes.notificationRoute: (context) => Notifications(),
      },
    );
  }
}

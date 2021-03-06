import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/search_provider.dart';
import 'package:windmill_general_trading/views/authentication/otp_screen.dart';
import 'package:windmill_general_trading/views/edit_profile.dart';
import 'package:windmill_general_trading/views/notification.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/verification_screen.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';


import 'cart_provider.dart';
import 'views/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Common.licensesFonts();
  await GetStorage.init();
  /*if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.instance.webInitialize(
      appId: "1329834907365798",
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
  }*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(providers: [
      ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      ChangeNotifierProvider<SearchProductProvider>(create: (_) => SearchProductProvider()),

    ],
    child: MaterialApp(
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
        AppRoutes.otpRoute: (context) => OtpScreen(),
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
    ),);

  }
}

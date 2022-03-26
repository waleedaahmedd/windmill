import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class Common {
  //PRIVACY POLICY AND TERMS-CONDITION URLS
  static const String PRIVACY_POLICY =
      "https://windmillcellar.com/privacy-policy/";
  static const String TERMS_AND_CONDITIONS =
      "https://windmillcellar.com/terms-and-conditions/";

  // Wordpress API Credentials
  static const String CONSUMER_KEY =
      "ck_f3c82188618fb5dcd7b4aa51a27187b7f9f3afb6";
  static const String CONSUMER_SECRET =
      "cs_8612c1dc210cd11ceb67cf10e1cc0ccfaf3be68a";
  static const String BASE_URL = "https://windmillcellar.com/wp-json/";
  static const String BASE_URl_NGENIOUS =
      "https://api-gateway.sandbox.ngenius-payments.com";
  static const String ngeniousApi =
      "YjRiM2JiYjQtYjEzOC00MDM3LWJhMWQtZGU4ZGJlNzBlOGY2OmJjZjIyZDUwLTlkMmEtNGYxMS05Zjk5LWY3Y2FjOTBlZGZkYg==";
  static const String API_URL = "https://windmillcellar.com/wp-json/wc/v3/";
  static const String REDIRECT_URL = "https://windmillcellar.com";

  // Application Name
  static String applicationName = "Windmill General Trading";

  // constants
  static const String DRIVER = "driver";
  static const String DRIVER_ASSIGNED = "driver-assigned";
  static const String COD = "cod";

  // assets constants
  static String assetsImages = "assets/images/";
  static String assetsIcons = "assets/icons/";

  //drawer navigation ket
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  // FIRE-STORE CONSTANTS
  static const String NOTIFICATIONS = "notifications";
  static const String USERS = "users";
  static const String WISHLISTS = "wishlists";
  static const String SHOPPING_CART = "shopping_cart";

  // get storage object field
  static const String PERSISTENT_STORAGE = "PERSISTENT_STORAGE";
  static const String PREFERENCE = "PREFERENCE";
  static const String TOKEN = "TOKEN";
  static const String ID = "ID";
  static const String outletId = '6782edef-036a-4ea6-a81c-fb72aa876246';

  //filtering constants
  static const String RECOMMENDED = "recommended";
  static const String NEW = "date"; // for api its date filter
  static const String DESC = "desc"; // make this desc
  static const String PRICE = "price"; // make this asc // desc
  static const String ASC = "asc"; // make this asc
  static const String DISCOUNT = "on_sale=true";

  static Future<void> licensesFonts() async {
    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/fonts/Montserrat/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/fonts/Poppins/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }

  // modal for sort and filter options
  static void showModalSheet(
    BuildContext context, {
    required String title,
    required Widget scrollViewPaddingChild,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext buildContext) {
        return StatefulBuilder(builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "${Common.assetsIcons}indicator_slider.png",
                  height: 20.0,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "$title",
                  style: GoogleFonts.montserrat(
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: scrollViewPaddingChild,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          );
        });
      },
    );
  }

  // navigation functions
  static void push(BuildContext context, Widget destinationScreen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => destinationScreen,
      ),
    );
  }

  static Future<void> pushAndDetectReturn(
      BuildContext context, Widget destinationScreen,
      {required Function(dynamic) onReturn}) async {
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => destinationScreen,
          ),
        )
        .then(onReturn);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushAndRemoveUntil(BuildContext context, Widget toScreen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => toScreen),
      (route) => false,
    );
  }

  static void showErrorTopSnack(BuildContext context, String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        icon: Icon(Icons.clear,color:Color(0xffff5252),),
        message: message,
      ),
    );
  }

  static void showSuccessTopSnack(BuildContext context, String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        icon: Icon(Icons.check,color: Colors.green,),
        message: message,
        backgroundColor: Colors.green,
      ),
    );
  }

  static Future<void> launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : print("Could not launch $url");
  }

  String encryptedHeader() {
    String credentials =
        "ck_925c9c90c1032a4604fcd8cdea5cdb1601da7b2e:cs_b609a8b41e647ea7832c9bf12a2e3a8b043948a9";
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded =
        stringToBase64Url.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
    // String decoded = stringToBase64Url.decode(encoded);
    return encoded;
  }

  static Future<void> logout(BuildContext context) async {
    await removeKey(Common.TOKEN);
    int _id = await getInt(Common.ID);
    await ApiRequests.deleteDeviceToken(_id.toString());
    final googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.disconnect();
    } on PlatformException catch (e) {
      print(e);
    }
    Common.pushAndRemoveUntil(context, Login());
  }

  static showPrimaryButtonDialog({
    required BuildContext context,
    required String dialogMessage,
    required String firstPrimaryButtonText,
    required Function() firstPrimaryButtonOnPressed,
    EdgeInsetsGeometry? buttonPadding,
    double? fontSize,
  }) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(Common.applicationName,style: GoogleFonts.montserrat(),),
        content: new Text(dialogMessage,style: GoogleFonts.montserrat(),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  onPressed: firstPrimaryButtonOnPressed,
                  title: firstPrimaryButtonText,
                  fontSize: fontSize,
                  padding: buttonPadding,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

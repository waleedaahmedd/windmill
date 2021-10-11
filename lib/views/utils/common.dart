import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class Common {
  // Application Name
  static String applicationName = "Windmill General Trading";

  // assets constants
  static String assetsImages = "assets/images/";
  static String assetsIcons = "assets/icons/";

  //drawer navigation ket
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

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
                  style: GoogleFonts.poppins(
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
}

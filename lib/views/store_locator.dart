import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class StoreLocator extends StatelessWidget {
  StoreLocator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WindmillAppBar(
            appBarColor: AppColors.appBlueColor,
            needBackIcon: true,
            title: "Store Locator",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appWhiteColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          PrimaryCard(
            child: Column(
              children: [
                Text(
                  "List of Stores will be visible here with contact information and opening-closing timeslots.",
                  style: GoogleFonts.poppins(
                    color: AppColors.appBlackColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

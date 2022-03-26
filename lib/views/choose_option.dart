import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class ChooseOption extends StatelessWidget {
  const ChooseOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "${Common.assetsImages}background.jpg",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "${Common.assetsImages}application_icon.png",
                          width: 60.0,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "Choose your option",
                      style: GoogleFonts.montserrat(
                        color: AppColors.appWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ChooseOptionCard(
                        title: "HOME DELIVERY",
                        cardColor: AppColors.primaryColor,
                        cardTextColor: AppColors.appWhiteColor,
                        toolTipText: "Abu Dhabi\nresidents only",
                        onPressed: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.dashboardRoute,
                          (route) => false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Expanded(
                      child: ChooseOptionCard(
                        title: "CLICK & COLLECT",
                        cardColor: AppColors.appWhiteColor,
                        cardTextColor: AppColors.primaryColor,
                        toolTipText: "Ghantaat\nShop only",
                        onPressed: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.dashboardRoute,
                          (route) => false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
                Text(
                  "CONDITIONS APPLY*",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: AppColors.appWhiteColor.withOpacity(0.5),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

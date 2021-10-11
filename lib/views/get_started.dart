import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${Common.assetsImages}background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    Image.asset(
                      "${Common.assetsImages}application_icon.png",
                      height: 100.0,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "WINDMILL",
                      style: TextStyle(
                        color: AppColors.appWhiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Shop local stores for beverages\nFree delivery on the same day",
                      style: TextStyle(
                        color: AppColors.appWhiteColor.withOpacity(0.5),
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryButton(
                      title: "REGISTER",
                      buttonBorder: Border.all(
                        color: AppColors.appWhiteColor,
                        width: 1.5,
                      ),
                      buttonColor: Colors.transparent,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.registerRoute),
                    ),
                    const SizedBox(height: 15.0),
                    PrimaryButton(
                      title: 'LOG IN',
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppRoutes.loginRoute),
                    ),
                    const SizedBox(height: 15.0),
                    ContinueWithAndSocialAuthSection(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

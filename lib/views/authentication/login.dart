import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();

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
                  "Welcome\nBack",
                  style: TextStyle(
                    color: AppColors.appWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(height: 60.0),
                LabelAndInputField(
                  fieldController: fullNameController,
                  label: 'Email Address',
                ),
                const SizedBox(height: 15.0),
                LabelAndInputField(
                  fieldController: fullNameController,
                  label: 'Password',
                ),
                // const SizedBox(height: 10.0),
                // InkWell(
                //   onTap: () => Navigator.of(context)
                //       .pushNamed(AppRoutes.forgetPasswordRoute),
                //   child: Text(
                //     "Forgot Password?",
                //     style: TextStyle(
                //       color: AppColors.primaryColor,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16.0,
                //     ),
                //     textAlign: TextAlign.right,
                //   ),
                // ),
                const SizedBox(height: 20.0),
                // TODO: change route to option choice screen later
                PrimaryButton(
                  title: "LOGIN",
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.chooseOptionRoute),
                ),
                const SizedBox(height: 10.0),
                InquiryTextButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    AppRoutes.registerRoute,
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

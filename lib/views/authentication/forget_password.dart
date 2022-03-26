import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      "Recover\nPassword",
                      style: GoogleFonts.montserrat(
                        color: AppColors.appWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    LabelAndInputField(
                      fieldController: fullNameController,
                      label: 'Email Address',
                    ),
                    const SizedBox(height: 20.0),
                    PrimaryButton(title: "RECOVER"),
                  ],
                ),
                const SizedBox(),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

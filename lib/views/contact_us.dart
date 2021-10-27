import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController feedbackController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WindmillAppBar(
            appBarColor: AppColors.appBlueColor,
            needBackIcon: true,
            title: "Contact Us",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appWhiteColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBlackColor.withOpacity(0.15),
                  offset: Offset(1, 2),
                  spreadRadius: 10.0,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "We Value your feedback, It Always help us improve our services and and source of motivation to us from potential users",
                  style: GoogleFonts.poppins(
                    color: AppColors.appBlackColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                LabelAndInputField(
                  fieldHeight: 50.0,
                  fieldController: nameController,
                  label: 'Name',
                  labelColor: AppColors.appBlackColor,
                  textColor: AppColors.appBlackColor,
                  borderColor: AppColors.appBlackColor,
                ),
                const SizedBox(height: 10.0),
                LabelAndInputField(
                  fieldHeight: 50.0,
                  fieldController: emailController,
                  label: 'Email Address',
                  labelColor: AppColors.appBlackColor,
                  textColor: AppColors.appBlackColor,
                  borderColor: AppColors.appBlackColor,
                ),
                const SizedBox(height: 10.0),
                LabelAndInputField(
                  fieldHeight: 50.0,
                  fieldController: feedbackController,
                  label: 'Feedback',
                  labelColor: AppColors.appBlackColor,
                  textColor: AppColors.appBlackColor,
                  borderColor: AppColors.appBlackColor,
                ),
                const SizedBox(height: 30.0),
                PrimaryButton(title: "Send"),
              ],
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

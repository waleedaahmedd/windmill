import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class InquiryTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? questionText, actionText;

  const InquiryTextButton({
    Key? key,
    this.onPressed,
    this.questionText,
    this.actionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            questionText ?? "Don't have an account?",
            style: TextStyle(
              color: AppColors.appWhiteColor.withOpacity(0.9),
              fontSize: 14.0,
            ),
          ),
          Text(
            actionText ?? " Register Now",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

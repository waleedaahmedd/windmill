import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? buttonColor, textColor;
  final String title;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? buttonBorder;

  const PrimaryButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.buttonBorder,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryColor,
          border: buttonBorder,
        ),
        padding: padding,
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              color: textColor ?? AppColors.appWhiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.6,
              fontSize: 17.0,
            ),
          ),
        ),
      ),
    );
  }
}

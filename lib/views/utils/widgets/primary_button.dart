import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? buttonColor, textColor;
  final String title;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? buttonBorder;
  final BorderRadius? borderRadius;
  final double? fontSize;

  const PrimaryButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.buttonBorder,
    this.borderRadius,
    this.fontSize,
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
          borderRadius: borderRadius,
        ),
        padding: padding,
        child: Center(
          child: Text(
            "$title",
            style: GoogleFonts.montserrat(
              color: textColor ?? AppColors.appWhiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.6,
              fontSize: fontSize ?? 17.0,
            ),
          ),
        ),
      ),
    );
  }
}

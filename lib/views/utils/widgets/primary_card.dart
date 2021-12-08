import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class PrimaryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding, margin;
  final VoidCallback? onPressed;

  const PrimaryCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: margin ??
            EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
        decoration: BoxDecoration(
          color: AppColors.appWhiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.appBlackColor.withOpacity(0.05),
              offset: Offset(1, 2),
              spreadRadius: 8.0,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

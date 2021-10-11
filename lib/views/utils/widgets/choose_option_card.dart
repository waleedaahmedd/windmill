import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class ChooseOptionCard extends StatelessWidget {
  final String title, toolTipText;
  final Color cardColor, cardTextColor;
  final EdgeInsetsGeometry? cardPadding;
  final VoidCallback? onPressed;

  const ChooseOptionCard({
    Key? key,
    required this.title,
    required this.toolTipText,
    required this.cardColor,
    required this.cardTextColor,
    this.cardPadding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: cardColor.withOpacity(0.2),
                  blurRadius: 20.0,
                  spreadRadius: 10.0,
                  offset: Offset(1, 5),
                ),
              ],
            ),
            padding: cardPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 40.0,
                ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: cardTextColor,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            "*$toolTipText",
            style: TextStyle(
              color: AppColors.appWhiteColor.withOpacity(0.6),
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}

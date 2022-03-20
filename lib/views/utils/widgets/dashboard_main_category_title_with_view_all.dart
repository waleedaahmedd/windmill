import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils_exporter.dart';

class DashboardMainCategoryTitleWithViewAll extends StatelessWidget {
  final String blackText, blueText;
  final VoidCallback? onPressed;

  const DashboardMainCategoryTitleWithViewAll({
    Key? key,
    required this.blackText,
    required this.blueText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Text(
                  "$blackText",
                  style: GoogleFonts.montserrat(
                    color: AppColors.appBlackColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  "$blueText",
                  style: GoogleFonts.montserrat(
                    color: AppColors.appBlueColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Text(
              "View all",
              style: TextStyle(
                color: Colors.blue.shade800
                /*AppColors.textColor.withOpacity(0.6)*/,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

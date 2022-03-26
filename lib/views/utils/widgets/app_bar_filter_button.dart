import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class AppBarFilterButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  const AppBarFilterButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.appGreyColor.withOpacity(0.9),
            ),
            const SizedBox(width: 5.0),
            Text(
              "$title",
              style: GoogleFonts.montserrat(
                color: AppColors.appGreyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

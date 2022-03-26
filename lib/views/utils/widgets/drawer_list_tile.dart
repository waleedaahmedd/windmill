import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.appBlackColor.withOpacity(0.35),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Text(
                "$title",
                style: GoogleFonts.montserrat(
                  color: AppColors.appBlackColor.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_right,
              color: AppColors.appBlackColor.withOpacity(0.35),
            ),
          ],
        ),
      ),
    );
  }
}

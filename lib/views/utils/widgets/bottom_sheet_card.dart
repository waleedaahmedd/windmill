import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class BottomSheetCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String? localImageURL;
  final VoidCallback? onPressed;

  const BottomSheetCard({
    Key? key,
    required this.isSelected,
    required this.title,
     this.localImageURL,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.appBlueColor
              : AppColors.appGreyColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        margin: const EdgeInsets.only(bottom: 3.0),
        child: Row(
          children: [
            Visibility(
              visible: localImageURL != null? true :false,
              child: Image.asset(
                "$localImageURL",
                width: 40.0,
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                "$title",
                style: GoogleFonts.poppins(
                  color: isSelected
                      ? AppColors.appWhiteColor
                      : AppColors.appBlackColor,
                  fontSize: 16.0,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

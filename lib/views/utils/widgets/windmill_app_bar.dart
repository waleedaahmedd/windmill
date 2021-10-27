import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class WindmillAppBar extends StatelessWidget {
  final TextEditingController? controller;
  final Color? hamburgerIconColor, appBarColor, backIconColor;
  final String? title, drawerColor;
  final bool needSearchBar, needBackIcon;
  final Widget? appBarTrailingIcon;
  final TextStyle? titleTS;
  final VoidCallback? onDrawerTap, onBackTap;

  const WindmillAppBar({
    Key? key,
    this.title,
    this.controller,
    this.hamburgerIconColor,
    this.needSearchBar = false,
    this.needBackIcon = false,
    this.appBarColor,
    this.appBarTrailingIcon,
    this.onDrawerTap,
    this.onBackTap,
    this.titleTS,
    this.backIconColor,
    this.drawerColor = "white",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  needBackIcon
                      ? InkWell(
                          onTap: onBackTap ?? () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: backIconColor ??
                                ((appBarColor == null)
                                    ? AppColors.appBlackColor
                                    : AppColors.appWhiteColor),
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: title != null
                        ? Text(
                            "$title",
                            style: titleTS ??
                                GoogleFonts.poppins(
                                  color:
                                      AppColors.appWhiteColor.withOpacity(0.7),
                                ),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                  ),
                  appBarTrailingIcon ??
                      Image.asset(
                        "${Common.assetsImages}application_icon.png",
                        height: 25.0,
                      ),
                ],
              ),
              needSearchBar ? const SizedBox(height: 10.0) : const SizedBox(),
              needSearchBar
                  ? LabelAndInputField(
                      fieldController: controller!,
                      label: "Search",
                      fieldHeight: 45.0,
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: AppColors.appWhiteColor,
                        size: 18.0,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

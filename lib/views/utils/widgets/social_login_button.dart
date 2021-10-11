import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class SocialLoginButton extends StatelessWidget {
  final String image;
  final VoidCallback? onPressed;

  const SocialLoginButton({
    Key? key,
    required this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.appWhiteColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Image.asset(
          "$image",
          width: 30.0,
          height: 30.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class ContinueWithAndSocialAuthSection extends StatelessWidget {
  final VoidCallback? googleOnPressed;
  final VoidCallback? fbOnPressed;

  const ContinueWithAndSocialAuthSection({
    Key? key,
    this.googleOnPressed,
    this.fbOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "-or continue with-",
          style: TextStyle(
            color: AppColors.appWhiteColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(
              image: "${Common.assetsIcons}googleG.png",
              onPressed: googleOnPressed,
            ),
            const SizedBox(width: 10.0),
            SocialLoginButton(
              image: "${Common.assetsIcons}facebookF.png",
              onPressed: fbOnPressed,
            ),
          ],
        ),
      ],
    );
  }
}

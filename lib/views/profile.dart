import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WindmillAppBar(
            title: "My Profile",
            titleTS: TextStyle(
              color: AppColors.appWhiteColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            appBarColor: AppColors.appBlueColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50.0,
                    backgroundImage: AssetImage(
                        "${Common.assetsImages}application_icon.png"),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Windmill Support",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "support@gmail.com",
                  style: TextStyle(
                    color: AppColors.appGreyColor.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60.0),
                ProfileCard(
                  title: "Terms And Conditions",
                  description:
                      "All terms related to application can be found here. we may update this time to time. you can get insights from here",
                ),
                const SizedBox(height: 4.0),
                ProfileCard(
                  title: "Privacy Policy",
                  description:
                      "We value your privacy and believe in security of your data. you can read our privacy policy in details here",
                ),
                const SizedBox(height: 4.0),
                ProfileCard(
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.loginRoute,
                    (route) => false,
                  ),
                  title: "Logout",
                  description:
                      "Hope to see you back soon. Keep exploring for quality food in discounted price.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title, description;
  final VoidCallback? onPressed;

  const ProfileCard({
    Key? key,
    required this.title,
    required this.description,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.appGreyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "$title",
                    style: TextStyle(
                      color: AppColors.appBlackColor.withOpacity(0.65),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 40.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: AppColors.appGreyColor.withOpacity(0.5),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              "$description",
              style: TextStyle(
                color: AppColors.appGreyColor,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

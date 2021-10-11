import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class WindmillDrawer extends StatelessWidget {
  const WindmillDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.appWhiteColor),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("${Common.assetsImages}background.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 42.0,
                          backgroundImage: AssetImage(
                            "${Common.assetsImages}demo_product.png",
                          ),
                        ),
                        Text(
                          "Windmill Support",
                          style: GoogleFonts.poppins(
                            color: AppColors.appWhiteColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "support@gmail.com",
                          style: GoogleFonts.poppins(
                            color: AppColors.appWhiteColor.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerListTile(
                      icon: Icons.home,
                      title: "Home",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.add_business,
                      title: "Shop",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(AppRoutes.shopBuyRoute);
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.shopping_cart,
                      title: "Shopping Cart",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(AppRoutes.shoppingCartRoute);
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.assignment_rounded,
                      title: "Orders History",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(AppRoutes.ordersRoute);
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.art_track_sharp,
                      title: "Blog",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(AppRoutes.blogRoute);
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.contacts_rounded,
                      title: "Contact Us",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(AppRoutes.contactUsRoute);
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.door_back,
                      title: "Logout",
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.loginRoute,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

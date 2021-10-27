import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindmillAppBar(
            appBarColor: AppColors.appBlueColor,
            needBackIcon: true,
            title: "Orders History",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appWhiteColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return OrderCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: 180.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appGreyColor.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: AssetImage(
                    "${Common.assetsImages}demo_product.png",
                  ),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                    AppColors.appBlackColor.withOpacity(0.8),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appBlueColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5.0,
                ),
                child: Text(
                  "Completed",
                  style: GoogleFonts.montserrat(
                    color: AppColors.appWhiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          "Product Title",
          style: GoogleFonts.montserrat(
            color: AppColors.appBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 0.8,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 2.5),
        Row(
          children: [
            Text(
              "Order Amount: 500 AED",
              style: GoogleFonts.poppins(
                color: AppColors.appBlackColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                "30 minutes ago",
                style: GoogleFonts.poppins(color: AppColors.appGreyColor),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        Divider(thickness: 1.0),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class DashboardHorizontalListCard extends StatelessWidget {
  final String image, productTitle, price;
  final String? discountPrice;
  final bool? isLocal;
  final double? width;
  final VoidCallback? onPressed;

  const DashboardHorizontalListCard({
    Key? key,
    required this.productTitle,
    required this.image,
    required this.price,
    this.isLocal = true,
    this.discountPrice,
    this.width,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ??
          () => Navigator.of(context).pushNamed(AppRoutes.productDetailRoute),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.appWhiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.appBlackColor.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(1, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.only(right: 10.0),
        padding: const EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: isLocal!
                        ? Image.asset("${Common.assetsImages}$image")
                        : Image.network("$image"),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appBlackColor.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: Offset(1, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.favorite,
                        size: 26.0,
                        color: AppColors.appBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$productTitle",
                    style: GoogleFonts.montserrat(
                      color: AppColors.appBlackColor.withOpacity(0.8),
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: -10,
                          children: [
                            Text(
                              "$price",
                              style: GoogleFonts.poppins(
                                color: AppColors.appBlackColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              "$price",
                              style: GoogleFonts.poppins(
                                color: AppColors.appBlackColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.appBlackColor,
                        size: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class ProductFavouriteCard extends StatelessWidget {
  final String title, description, price, location;
  final VoidCallback? onPressed;
  const ProductFavouriteCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ??
          () => Navigator.of(context).pushNamed(AppRoutes.productDetailRoute),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      '${Common.assetsImages}demo_product.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appBlackColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 7.0),
                      Text(
                        '$description',
                        style: TextStyle(
                          color: AppColors.appGreyColor,
                          fontSize: 15.0,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.appGreyColor.withOpacity(0.6),
                            size: 18.0,
                          ),
                          Expanded(
                            child: Text(
                              '$location',
                              style: TextStyle(
                                color: AppColors.appGreyColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$$price",
                              style: TextStyle(
                                color: AppColors.appBlackColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.appGreyColor,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
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
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.favorite,
                size: 22.0,
                color: AppColors.appBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

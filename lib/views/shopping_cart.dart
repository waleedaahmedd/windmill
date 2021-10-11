import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class ShoppingCart extends StatelessWidget {
  ShoppingCart({Key? key}) : super(key: key);

  TextEditingController couponController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindmillAppBar(
            drawerColor: "black",
            needBackIcon: Navigator.of(context).canPop(),
            backIconColor: AppColors.appBlackColor,
            needDrawer: !Navigator.of(context).canPop(),
            title: "My CartList",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appBlackColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Total items (2)",
                    style: GoogleFonts.montserrat(
                      color: AppColors.appBlackColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    "${Common.assetsImages}demo_product.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Product Title",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.appBlackColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 2.5),
                                      Text(
                                        "Product Title",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.appGreyColor,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 90.0,
                                            decoration: BoxDecoration(
                                              color: AppColors.appBlueColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4.0,
                                              horizontal: 10.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.minus,
                                                  size: 16.0,
                                                  color:
                                                      AppColors.appWhiteColor,
                                                ),
                                                Text(
                                                  '1',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.appWhiteColor,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.add,
                                                  size: 16.0,
                                                  color:
                                                      AppColors.appWhiteColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '\$450',
                                              style: GoogleFonts.montserrat(
                                                color: AppColors.appBlackColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Divider(
                              color: AppColors.appBlueColor,
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: AppColors.appBlueColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelAndInputField(
              fieldHeight: 50.0,
              fieldController: couponController,
              labelSize: 13.0,
              fontSize: 13.0,
              prefixIcon: Icon(
                Icons.ac_unit_sharp,
                color: AppColors.appWhiteColor.withOpacity(0.6),
              ),
              label: "Do you have any discount or coupon code",
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub-Total",
                  style: GoogleFonts.poppins(
                    color: AppColors.appWhiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "AED 400",
                  style: GoogleFonts.poppins(
                    color: AppColors.appWhiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: GoogleFonts.poppins(
                    color: AppColors.appWhiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "AED 50",
                  style: GoogleFonts.poppins(
                    color: AppColors.appWhiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Divider(
              thickness: 0.5,
              color: AppColors.appWhiteColor,
            ),
            const SizedBox(height: 60.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.dashboardRoute,
                      (route) => false,
                    ),
                    child: Text(
                      'CONTINUE SHOPPING',
                      style: GoogleFonts.montserrat(
                        color: AppColors.appWhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Place Order',
                      style: GoogleFonts.montserrat(
                        color: AppColors.appWhiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WindmillAppBar(
              needSearchBar: true,
              controller: searchController,
              title: "Click & Collect - Ghantaat",
              appBarColor: AppColors.appBlueColor,
            ),
            CarouselSlider(
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: AssetImage(
                            "${Common.assetsImages}product_banner.jpg",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 6 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 1600),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged:
                    (int pageCount, CarouselPageChangedReason reason) {
                  print("Page Scrolled: $pageCount with Reason: $reason");
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            DashboardMainCategoryTitleWithViewAll(
              blackText: "Special",
              blueText: "Offers",
            ),
            SizedBox(
              height: 236.0,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 8.0,
                  top: 1.0,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return DashboardHorizontalListCard(
                    productTitle: "Product Title comes here",
                    price: "\$550",
                    image: "demo_product.png",
                    width: 160.0,
                  );
                },
              ),
            ),
            DashboardMainCategoryTitleWithViewAll(
              blackText: "Trending",
              blueText: "Products",
            ),
            SizedBox(
              height: 236.0,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 8.0,
                  top: 1.0,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return DashboardHorizontalListCard(
                    productTitle: "Product Title comes here",
                    price: "\$550",
                    image: "demo_product.png",
                    width: 160.0,
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              child: Stack(
                children: [
                  Image.asset("${Common.assetsImages}product_banner.jpg"),
                  Positioned.fill(
                    right: 30.0,
                    left: 160.0,
                    child: Center(
                      child: Text(
                        "Nobody Will miss out on a memory because they were schlepping to a liquor store.",
                        style: GoogleFonts.montserrat(
                          color: AppColors.appWhiteColor.withOpacity(0.7),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            DashboardMainCategoryTitleWithViewAll(
              blackText: "Top",
              blueText: "Sellers",
            ),
            SizedBox(
              height: 236.0,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 8.0,
                  top: 1.0,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return DashboardHorizontalListCard(
                    productTitle: "Product Title comes here",
                    price: "\$550",
                    image: "demo_product.png",
                    width: 160.0,
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/api_requests/testing_data.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class ShopBuy extends StatelessWidget {
  ShopBuy({Key? key}) : super(key: key);

  final List<Widget> categoryTabs = [
    Beer(),
    Wine(),
    Liquor(),
  ];

  List<Widget> tabs = [
    CustomTab(
      title: "Beer",
    ),
    CustomTab(
      title: "Wine",
    ),
    CustomTab(
      title: "Liquor",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoryTabs.length,
      child: Scaffold(
        body: Column(
          children: [
            WindmillAppBar(
              appBarColor: AppColors.appBlueColor,
              needDrawer: !Navigator.of(context).canPop(),
              needBackIcon: Navigator.of(context).canPop(),
              title: "Shop",
              titleTS: TextStyle(
                color: AppColors.appWhiteColor,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appGreyColor.withOpacity(0.15),
                    offset: Offset(1, 2),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TabBar(
                tabs: tabs,
                indicatorColor: AppColors.appBlueColor,
                labelColor: AppColors.appBlackColor,
              ),
            ),
            Expanded(
              child: TabBarView(children: categoryTabs),
            ),
          ],
        ),
      ),
    );
  }
}

class Beer extends StatelessWidget {
  const Beer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.appGreyColor.withOpacity(0.2),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                AppBarFilterButton(
                  onPressed: () => Common.showModalSheet(
                    context,
                    title: "Sort",
                    scrollViewPaddingChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BottomSheetCard(
                          title: "Recommended",
                          isSelected: true,
                          localImageURL:
                              "${Common.assetsImages}application_icon.png",
                        ),
                        BottomSheetCard(
                          title: "New",
                          isSelected: false,
                          localImageURL:
                              "${Common.assetsImages}application_icon.png",
                        ),
                        BottomSheetCard(
                          title: "High to low",
                          isSelected: false,
                          localImageURL:
                              "${Common.assetsImages}application_icon.png",
                        ),
                        BottomSheetCard(
                          title: "Low to high",
                          isSelected: false,
                          localImageURL:
                              "${Common.assetsImages}application_icon.png",
                        ),
                        BottomSheetCard(
                          title: "Discount",
                          isSelected: false,
                          localImageURL:
                              "${Common.assetsImages}application_icon.png",
                        ),
                      ],
                    ),
                  ),
                  title: "Sort",
                  icon: Icons.sort,
                ),
                AppBarFilterButton(
                  title: "Filter",
                  icon: Icons.filter_alt_sharp,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 35.0,
            margin: const EdgeInsets.only(left: 20.0),
            child: ListView.builder(
              itemCount: TestingData.beerCategories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final String categoryTitle = TestingData.beerCategories[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.appBlueColor,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: const EdgeInsets.only(right: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      categoryTitle,
                      style: GoogleFonts.poppins(
                        color: AppColors.appBlueColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return DashboardHorizontalListCard(
                  productTitle: 'Title of the product',
                  price: '\$500',
                  image: 'demo_product.png',
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Wine extends StatelessWidget {
  const Wine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}

class Liquor extends StatelessWidget {
  const Liquor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  const CustomTab({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        "$title",
        style: TextStyle(
          color: AppColors.appGreyColor.withOpacity(0.8),
        ),
      ),
    );
  }
}

//Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Row(
//                   children: [
//                     AppBarFilterButton(
//                       title: "Sort By",
//                       icon: Icons.sort_outlined,
//                     ),
//                     AppBarFilterButton(
//                       title: "Filter",
//                       icon: Icons.filter_alt_sharp,
//                     ),
//                   ],
//                 ),
//               ),

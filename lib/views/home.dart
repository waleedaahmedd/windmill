import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<ProductModal>? _trendingProducts,
      _recentPostedProducts,
      _topPricesProducts;

  // loading variables
  bool _isTrendingLoading = true;
  bool _isRecentLoading = true;
  bool _isTopLoading = true;

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  // TODO: categories / filters
  // TODO: facebook login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WindmillAppBar(
            needSearchBar: true,
            controller: searchController,
            title: "Click & Collect - Ghantaat",
            appBarColor: AppColors.appBlueColor,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5, top: 10,bottom: 10),
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              height:30,
                              child: Image.asset(
                                "${Common.assetsImages}free-delivery.png",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Free Delivery',style: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18
                                  ),),
                                  Container(
                                      width: 100,
                                      child: Text('From AED 150 within Abu Dhabi & Al Ain only',
                                        style: TextStyle(
                                            fontSize: 12
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                            ),

                          ],
                        ),
                      )
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5,right: 10, top: 10,bottom: 10),
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              height:30,
                              child: Image.asset(
                                "${Common.assetsImages}click-collect.png",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Click & Collect',style: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18
                                  ),),
                                  Container(
                                      width: 100,
                                      child: Text('Shop at your fingertips and collect at Ghantoot',
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                            ),

                          ],
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    blackText: "Featured",
                    blueText: "Products",
                  ),
                  SizedBox(
                    height: 236.0,
                    child: _isRecentLoading
                        ? CupertinoActivityIndicator()
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              bottom: 8.0,
                              top: 1.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _recentPostedProducts?.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              print(_recentPostedProducts?.length);
                              ProductModal _product =
                                  _recentPostedProducts![index];
                              return DashboardHorizontalListCard(
                                product: _product,
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
                    child: _isTrendingLoading
                        ? CupertinoActivityIndicator()
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              bottom: 8.0,
                              top: 1.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _trendingProducts?.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              ProductModal _product = _trendingProducts![index];
                              return DashboardHorizontalListCard(
                                product: _product,
                                width: 160.0,
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 10.0),
                  Stack(
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
                  const SizedBox(height: 10.0),
                  DashboardMainCategoryTitleWithViewAll(
                    blackText: "Top",
                    blueText: "Sellers",
                  ),
                  SizedBox(
                    height: 236.0,
                    child: _isTopLoading
                        ? CupertinoActivityIndicator()
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              bottom: 8.0,
                              top: 1.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _topPricesProducts?.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              ProductModal _product =
                                  _topPricesProducts![index];
                              return DashboardHorizontalListCard(
                                product: _product,
                                width: 160.0,
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getProducts() async {
    _trendingProducts =
        await ApiRequests.getProducts(orderBy: "popularity", order: Common.ASC);
    _isTrendingLoading = false;
    if (mounted) setState(() {});
      _recentPostedProducts =
        await ApiRequests.getProducts(orderBy: "date", order: Common.ASC);
    _isRecentLoading = false;
    if (mounted) setState(() {});
    _topPricesProducts =
        await ApiRequests.getProducts(orderBy: "price", order: Common.ASC);
    _isTopLoading = false;
    if (mounted) setState(() {});
  }
}

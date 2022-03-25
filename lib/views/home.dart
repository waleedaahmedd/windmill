import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/product/product_detail.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

import '../search_provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<ProductModal>? _trendingProducts, _featuredProducts, _onSaleProducts;

  List<String> images = [
    "${Common.assetsImages}banner2.jpg",
    "${Common.assetsImages}banner3.jpg",
    "${Common.assetsImages}banner4.jpg",
    "${Common.assetsImages}banner5.jpg"
  ];

  // loading variables
  bool _isTrendingLoading = true;
  bool _isFeaturedLoading = true;
  bool _isOnSaleLoading = true;

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  // TODO: categories / filters
  // TODO: facebook login

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProductProvider>(builder: (context, i, _) {
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
            Visibility(
              visible: i.productList.isEmpty? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 300,
                  child: Center(
                    child: ListView.builder(
                      itemCount: i.productList.length,
                      itemBuilder: (context, index) {
                        /*    if(i.productList[index]){*/
                        return Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                onTap: () {
                                  Common.push(
                                    context,
                                    ProductDetail(product: i.productList[index]),
                                  );
                                },
                                dense: true,
                                leading: SizedBox(
                                  height: 200,
                                  width: 50,
                                  child: Image.network(
                                    '${i.productList[index].images.first.src}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                               // horizontalTitleGap: 50,
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('${i.productList[index].name}',style: TextStyle(color: Colors.blueAccent),),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Html(data: "${i.productList[index].shortDescription}",),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Row(
                                        children: [
                                          Visibility(
                                            visible: i.productList[index].salePrice != "" ? true : false,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 10.0),
                                              child: Text('AED ${i.productList[index].regularPrice}',style: TextStyle(color: Colors.grey,
                                                  decoration: TextDecoration.lineThrough),),
                                            ),
                                          ),
                                          Text('AED ${i.productList[index].price}',style: TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                  trailing: Visibility(
                                    visible: i.productList[index].onSale,
                                    child: Container(
                                      color: Colors.lightGreen,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text('Sale',style: TextStyle(color: Colors.white),),
                                      ),),
                                  )
                              ),
                            ),
                          ),
                        );
                        /*  }*/
                      },
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 5, top: 10, bottom: 10),
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
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
                                    Text(
                                      'Free Delivery',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'From AED 150 within Abu Dhabi & Al Ain only',
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10, top: 10, bottom: 10),
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
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
                                    Text(
                                      'Click & Collect',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Container(
                                        width: 100,
                                        child: Text(
                                          'Shop at your fingertips and collect at Ghantoot',
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "$i",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 150,
                        //aspectRatio: 6 / 9,
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
                          print(
                              "Page Scrolled: $pageCount with Reason: $reason");
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
                      child: _isFeaturedLoading
                          ? CupertinoActivityIndicator()
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 8.0,
                                top: 1.0,
                              ),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _featuredProducts?.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                print(_featuredProducts?.length);
                                ProductModal _product =
                                    _featuredProducts![index];
                                return DashboardHorizontalListCard(
                                  product: _product,
                                  width: 160.0,
                                );
                              },
                            ),
                    ),
                    DashboardMainCategoryTitleWithViewAll(
                      blackText: "On",
                      blueText: "Trending",
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
                                ProductModal _product =
                                    _trendingProducts![index];
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
                        Image.asset("${Common.assetsImages}banner3.jpg"),
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
                      blackText: "On",
                      blueText: "Sale",
                    ),
                    SizedBox(
                      height: 236.0,
                      child: _isOnSaleLoading
                          ? CupertinoActivityIndicator()
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 8.0,
                                top: 1.0,
                              ),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _onSaleProducts?.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                ProductModal _product = _onSaleProducts![index];
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
    });
  }

  Future<void> _getProducts() async {
    _featuredProducts =
        await ApiRequests.getProductByType('featured=true', 5, 1);
    _isFeaturedLoading = false;
    if (mounted) setState(() {});
    _trendingProducts =
        await ApiRequests.getProductByType('orderby=popularity', 5, 1);
    _isTrendingLoading = false;
    if (mounted) setState(() {});
    _onSaleProducts = await ApiRequests.getProductByType('on_sale=true', 5, 1);
    _isOnSaleLoading = false;
    if (mounted) setState(() {});
  }
}

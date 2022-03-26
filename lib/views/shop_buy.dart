import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import '../search_provider.dart';

class ShopBuy extends StatelessWidget {
  ShopBuy({Key? key}) : super(key: key);

  final List<Widget> categoryTabs = [
    All(),
    Beer(),
    Liquor(),
    Wine(),
    Sale(),
  ];

  TextEditingController searchController = TextEditingController();

  List<Widget> tabs = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text('All',style: GoogleFonts.montserrat(),),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text('Beers',style: GoogleFonts.montserrat(),),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text('Spirits',style: GoogleFonts.montserrat(),),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text('Wines',style: GoogleFonts.montserrat(),),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text('Sale',style: GoogleFonts.montserrat(),),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProductProvider>(builder: (context, i, _) {
      return DefaultTabController(
        length: categoryTabs.length,
        child: Scaffold(
          body: Column(
            children: [
              WindmillAppBar(
                needSearchBar: true,
                controller: searchController,
                appBarColor: AppColors.appBlueColor,
                needBackIcon: Navigator.of(context).canPop(),
                title: "Shop",
                titleTS: TextStyle(
                  color: AppColors.appWhiteColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Visibility(
                visible: i.productList.isEmpty ? false : true,
                child: Container(
                  height: 300,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      ProductDetail(
                                          product: i.productList[index]),
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
                                    child: Text(
                                      '${i.productList[index].name}',
                                      style:
                                      GoogleFonts.montserrat(color: Colors.blueAccent),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Html(
                                          data:
                                              "${i.productList[index].shortDescription}",
                                          style: {
                                            '#': Style(
                                              fontSize: FontSize(12),
                                              maxLines: 2,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          }),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible: i.productList[index]
                                                          .salePrice !=
                                                      ""
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Text(
                                                  'AED ${i.productList[index].regularPrice}',
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'AED ${i.productList[index].price}',
                                              style:
                                              GoogleFonts.montserrat(color: Colors.red),
                                            ),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          'Sale',
                                          style: GoogleFonts.montserrat(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        );
                        /*  }*/
                      },
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 20),
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
                  indicator: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 2)),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBlueColor),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              Expanded(
                child: TabBarView(children: categoryTabs),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  List<ProductModal>? _allProducts;
  String _sortingBy = Common.RECOMMENDED;
  String _order = Common.DESC;
  bool _isAllProductsLoading = true;

  @override
  void initState() {
    _getAllProducts();
    super.initState();
  }

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
                          onPressed: () => _updateSortingBy(Common.RECOMMENDED),
                          title: "Recommended",
                          isSelected: (_sortingBy == Common.RECOMMENDED),
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () => _updateSortingBy(Common.NEW),
                          title: "New",
                          isSelected: (_sortingBy == Common.NEW),
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () => _updateSortingBy(Common.PRICE,
                              order: Common.DESC),
                          title: "High to low",
                          isSelected: (_sortingBy == Common.PRICE &&
                              _order == Common.DESC),
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () =>
                              _updateSortingBy(Common.PRICE, order: Common.ASC),
                          title: "Low to high",
                          isSelected: (_sortingBy == Common.PRICE &&
                              _order == Common.ASC),
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () => _updateSortingBy(Common.DISCOUNT),
                          title: "Discount",
                          isSelected: (_sortingBy == Common.DISCOUNT),
                          /*  localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Sort",
                  icon: Icons.sort,
                ),
                AppBarFilterButton(
                  onPressed: () => Common.showModalSheet(
                    context,
                    title: "Filter",
                    scrollViewPaddingChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BottomSheetCard(
                          title: "Category",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                          onPressed: () {
                            if (_isAllProductsLoading) return;
                            // popping to close bottom sheet
                            Common.pop(context);
                            Common.pushAndDetectReturn(
                              context,
                              SubFilterList(
                                categoryTitle: 'Category',
                                categoryId: 25,
                              ),
                              onReturn: (value) async {
                                // user returned after pop
                                // check if user selected any filtering categories or not
                                // if categories select then filter products by it
                                _toggleListLoading();

                                PersistentStorage _persistentStorage =
                                    PersistentStorage();
                                List<Category> _selectedCategories = [];
                                _selectedCategories = _persistentStorage
                                            .getSelectedCategories(25) ==
                                        null
                                    ? []
                                    : _persistentStorage
                                        .getSelectedCategories(25)!;

                                String _categories = "";
                                for (int i = 0;
                                    i < _selectedCategories.length;
                                    i++) {
                                  _categories +=
                                      _selectedCategories[i].id.toString();
                                  if (i < _selectedCategories.length - 1)
                                    _categories += ",";
                                }

                                _allProducts =
                                    await ApiRequests.getProductsByCategory(
                                  category: 25,
                                  categories: _categories,
                                );
                                _toggleListLoading();
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Colors",
                          isSelected: false,
                          /*  localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Sizes",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Prices",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Bundles",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Filter",
                  icon: Icons.filter_alt_sharp,
                ),
              ],
            ),
          ),
          Expanded(
            child: _isAllProductsLoading
                ? CupertinoActivityIndicator()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _allProducts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModal _product = _allProducts![index];
                      return DashboardHorizontalListCard(product: _product);
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

  void _getAllProducts() async {
    _allProducts = await ApiRequests.getAllProduct(10,1);
    _toggleListLoading();
  }

  void _toggleListLoading() {
    _isAllProductsLoading = !_isAllProductsLoading;
    if (mounted) setState(() {});
  }

  Future<void> _updateProductsListings(String sortingBy,
      {String order = Common.DESC}) async {
    _toggleListLoading();

    // get products by sorting filter
    _order = order;

    _allProducts = await ApiRequests.getProductsByCategory(
      category: 25,
      orderBy: sortingBy,
      order: _order,
    );

    _toggleListLoading();
  }

  Future<void> _updateSortingBy(String sortingBy,
      {String order = Common.DESC}) async {
    // update the listing only if sorting field is not same as previously selected
    bool _updateProductListings =
        ((sortingBy != _sortingBy) || (order != _order));
    _sortingBy = sortingBy;
    Common.pop(context);
    if (_updateProductListings)
      await _updateProductsListings(
        _sortingBy,
        order: order,
      );
    if (mounted) setState(() {});
  }

  Future<void> _getProductsBySelectedCategories(
      List<Category> selectedSubCategories) async {
    _toggleListLoading();

    selectedSubCategories.forEach((category) {
      print(category.id);
    });

    _toggleListLoading();
  }
}

class Beer extends StatefulWidget {
  const Beer({Key? key}) : super(key: key);

  @override
  State<Beer> createState() => _BeerState();
}

class _BeerState extends State<Beer> {
  List<ProductModal>? _beerProducts;
  String _sortingBy = Common.RECOMMENDED;
  String _order = Common.DESC;
  bool _isBeerProductsLoading = true;

  @override
  void initState() {
    _getBeerProducts();
    super.initState();
  }

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
                          onPressed: () => _updateSortingBy(Common.RECOMMENDED),
                          title: "Recommended",
                          isSelected: (_sortingBy == Common.RECOMMENDED),
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () => _updateSortingBy(Common.NEW),
                          title: "New",
                          isSelected: (_sortingBy == Common.NEW),
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () => _updateSortingBy(Common.PRICE,
                              order: Common.DESC),
                          title: "High to low",
                          isSelected: (_sortingBy == Common.PRICE &&
                              _order == Common.DESC),
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () =>
                              _updateSortingBy(Common.PRICE, order: Common.ASC),
                          title: "Low to high",
                          isSelected: (_sortingBy == Common.PRICE &&
                              _order == Common.ASC),
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          onPressed: () => _updateSortingBy(Common.DISCOUNT),
                          title: "Discount",
                          isSelected: (_sortingBy == Common.DISCOUNT),
                          /*  localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Sort",
                  icon: Icons.sort,
                ),
                AppBarFilterButton(
                  onPressed: () => Common.showModalSheet(
                    context,
                    title: "Filter",
                    scrollViewPaddingChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BottomSheetCard(
                          title: "Category",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                          onPressed: () {
                            if (_isBeerProductsLoading) return;
                            // popping to close bottom sheet
                            Common.pop(context);
                            Common.pushAndDetectReturn(
                              context,
                              SubFilterList(
                                categoryTitle: 'Category',
                                categoryId: 25,
                              ),
                              onReturn: (value) async {
                                // user returned after pop
                                // check if user selected any filtering categories or not
                                // if categories select then filter products by it
                                _toggleListLoading();

                                PersistentStorage _persistentStorage =
                                    PersistentStorage();
                                List<Category> _selectedCategories = [];
                                _selectedCategories = _persistentStorage
                                            .getSelectedCategories(25) ==
                                        null
                                    ? []
                                    : _persistentStorage
                                        .getSelectedCategories(25)!;

                                String _categories = "";
                                for (int i = 0;
                                    i < _selectedCategories.length;
                                    i++) {
                                  _categories +=
                                      _selectedCategories[i].id.toString();
                                  if (i < _selectedCategories.length - 1)
                                    _categories += ",";
                                }

                                _beerProducts =
                                    await ApiRequests.getProductsByCategory(
                                  category: 25,
                                  categories: _categories,
                                );
                                _toggleListLoading();
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Colors",
                          isSelected: false,
                          /*  localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Sizes",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Prices",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Bundles",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Filter",
                  icon: Icons.filter_alt_sharp,
                ),
              ],
            ),
          ),
          Expanded(
            child: _isBeerProductsLoading
                ? CupertinoActivityIndicator()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _beerProducts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModal _product = _beerProducts![index];
                      return DashboardHorizontalListCard(product: _product);
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

  void _getBeerProducts() async {
    _beerProducts = await ApiRequests.getProductsByCategory(category: 25);
    _toggleListLoading();
  }

  void _toggleListLoading() {
    _isBeerProductsLoading = !_isBeerProductsLoading;
    if (mounted) setState(() {});
  }

  Future<void> _updateProductsListings(String sortingBy,
      {String order = Common.DESC}) async {
    _toggleListLoading();

    // get products by sorting filter
    _order = order;

    _beerProducts = await ApiRequests.getProductsByCategory(
      category: 25,
      orderBy: sortingBy,
      order: _order,
    );

    _toggleListLoading();
  }

  Future<void> _updateSortingBy(String sortingBy,
      {String order = Common.DESC}) async {
    // update the listing only if sorting field is not same as previously selected
    bool _updateProductListings =
        ((sortingBy != _sortingBy) || (order != _order));
    _sortingBy = sortingBy;
    Common.pop(context);
    if (_updateProductListings)
      await _updateProductsListings(
        _sortingBy,
        order: order,
      );
    if (mounted) setState(() {});
  }

  Future<void> _getProductsBySelectedCategories(
      List<Category> selectedSubCategories) async {
    _toggleListLoading();

    selectedSubCategories.forEach((category) {
      print(category.id);
    });

    _toggleListLoading();
  }
}

class Wine extends StatefulWidget {
  const Wine({Key? key}) : super(key: key);

  @override
  State<Wine> createState() => _WineState();
}

class _WineState extends State<Wine> {
  List<ProductModal>? _wineProducts;
  bool _isWineProductsLoading = true;

  @override
  void initState() {
    _getWineProducts();
    super.initState();
  }

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
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "New",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "High to low",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Low to high",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Discount",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Sort",
                  icon: Icons.sort,
                ),
                AppBarFilterButton(
                  onPressed: () => Common.showModalSheet(
                    context,
                    title: "Filter",
                    scrollViewPaddingChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BottomSheetCard(
                          title: "Category",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubFilterList(
                                categoryTitle: 'Category',
                                categoryId: 27,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Brands",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Colors",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Sizes",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Prices",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "New Arrivals",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Bundles",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Discounted Products",
                          isSelected: true,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Filter",
                  icon: Icons.filter_alt_sharp,
                ),
              ],
            ),
          ),
          Expanded(
            child: _isWineProductsLoading
                ? CupertinoActivityIndicator()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _wineProducts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModal _product = _wineProducts![index];
                      return DashboardHorizontalListCard(product: _product);
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

  void _getWineProducts() async {
    _wineProducts = await ApiRequests.getProductsByCategory(category: 27);
    _isWineProductsLoading = false;
    if (mounted) setState(() {});
  }
}

class Liquor extends StatefulWidget {
  const Liquor({Key? key}) : super(key: key);

  @override
  State<Liquor> createState() => _LiquorState();
}

class _LiquorState extends State<Liquor> {
  List<ProductModal>? _liquorProducts;
  bool _isLiquorProductsLoading = true;

  @override
  void initState() {
    _getLiquorProducts();
    super.initState();
  }

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
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "New",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "High to low",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Low to high",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Discount",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Sort",
                  icon: Icons.sort,
                ),
                AppBarFilterButton(
                  onPressed: () => Common.showModalSheet(
                    context,
                    title: "Filter",
                    scrollViewPaddingChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BottomSheetCard(
                          title: "Category",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubFilterList(
                                categoryTitle: 'Category',
                                categoryId: 113,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Brands",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Colors",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Sizes",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Prices",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "New Arrivals",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Bundles",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Discounted Products",
                          isSelected: true,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Filter",
                  icon: Icons.filter_alt_sharp,
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLiquorProductsLoading
                ? CupertinoActivityIndicator()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _liquorProducts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModal _product = _liquorProducts![index];
                      return DashboardHorizontalListCard(product: _product);
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

  void _getLiquorProducts() async {
    _liquorProducts = await ApiRequests.getProductsByCategory(category: 113);
    _isLiquorProductsLoading = false;
    if (mounted) setState(() {});
  }
}

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  List<ProductModal>? _saleProducts;
  bool _isSaleProductsLoading = true;

  @override
  void initState() {
    _getSaleProducts();
    super.initState();
  }

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
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "New",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "High to low",
                          isSelected: false,
                          /* localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Low to high",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Discount",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Sort",
                  icon: Icons.sort,
                ),
                AppBarFilterButton(
                  onPressed: () => Common.showModalSheet(
                    context,
                    title: "Filter",
                    scrollViewPaddingChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BottomSheetCard(
                          title: "Category",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubFilterList(
                                categoryTitle: 'Category',
                                categoryId: 113,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Brands",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Colors",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Sizes",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Prices",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "New Arrivals",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Bundles",
                          isSelected: false,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BottomSheetCard(
                          title: "Discounted Products",
                          isSelected: true,
                          /*localImageURL:
                              "${Common.assetsImages}application_icon.png",*/
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  title: "Filter",
                  icon: Icons.filter_alt_sharp,
                ),
              ],
            ),
          ),
          Expanded(
            child: _isSaleProductsLoading
                ? CupertinoActivityIndicator()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _saleProducts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModal _product = _saleProducts![index];
                      return DashboardHorizontalListCard(product: _product);
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

  void _getSaleProducts() async {
    _saleProducts = await ApiRequests.getProductByType('on_sale=true', 10, 1);
    _isSaleProductsLoading = false;
    if (mounted) setState(() {});
  }

/*void _getSaleProducts() async {
    _saleProducts = await ApiRequests.getProductsByCategory(category: 113);
    _isSaleProductsLoading = false;
    if (mounted) setState(() {});
  }*/
}

/*class CustomTab extends StatelessWidget {
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
          color: AppColors.appGreyColor,fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}*/

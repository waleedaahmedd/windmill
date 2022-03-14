import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  TextEditingController couponController = new TextEditingController();
  bool _isCartLoading = true,
      _isQuantityLoading = false,
      _isSubTotalLoading = false,
      _isOrderProcessing = false;

  String _userID = "";
  double _subTotal = 0, _discount = 0;
  ShoppingCartModal? _shoppingCart;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _toggleCartLoading({bool? isLoading}) {
    _isCartLoading = isLoading ?? !_isCartLoading;
    if (mounted) setState(() {});
  }

  void _toggleSubTotalLoading({bool? isLoading}) {
    _isSubTotalLoading = isLoading ?? !_isSubTotalLoading;
    if (mounted) setState(() {});
  }

  void _toggleQuantityLoading({bool? isLoading}) {
    _isQuantityLoading = isLoading ?? !_isQuantityLoading;
    if (mounted) setState(() {});

    // if loading ended then start function to get sub-total
    if (!_isQuantityLoading) _getSubTotal();
  }

  void _decrementProductQuantity(String productId) async {
    if (!_isQuantityLoading) {
      _toggleQuantityLoading();

      await ApiRequests.processAddProductToCart(
        productId,
        1,
        _userID,
        context: context,
        needDecrementOnQuantity: true,
        needIncrementOnQuantity: false,
      );

      _toggleQuantityLoading();
    }
  }

  void _removeProductFromUserCart(String productId) async {
    if (!_isQuantityLoading) {
      _toggleQuantityLoading();

      await ApiRequests.removeItemFromShoppingCart(_userID, productId);

      _toggleQuantityLoading();
    }
  }

  void _incrementProductQuantity(String productId) async {
    if (!_isQuantityLoading) {
      _toggleQuantityLoading();

      await ApiRequests.processAddProductToCart(
        productId,
        1,
        _userID,
        context: context,
      );

      _toggleQuantityLoading();
    }
  }

  void _getSubTotal() async {
    _toggleSubTotalLoading();

    _subTotal = await ApiRequests.getSubTotalForShoppingCart(_userID);

    _toggleSubTotalLoading();
  }

  void _getUser() async {
    int _id = await getInt(Common.ID);
    _userID = _id.toString();

    _toggleCartLoading();
    _getSubTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindmillAppBar(
            drawerColor: "black",
            needBackIcon: Navigator.of(context).canPop(),
            backIconColor: AppColors.appBlackColor,
            title: "My CartList",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appBlackColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          _isCartLoading
              ? LoadingOverlay()
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 2.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: ApiRequests.getInCartProducts(_userID),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              if (snapshot.data!.size == 0) {
                                return Text(
                                  "Total items (0)",
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.appBlackColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              ShoppingCartModal __shoppingCart =
                                  ShoppingCartModal.fromJson(
                                      snapshot.data?.docs.first.data()
                                          as Map<String, dynamic>);
                              _shoppingCart = __shoppingCart;
                              return Text(
                                "Total items (${__shoppingCart.products.length})",
                                style: GoogleFonts.montserrat(
                                  color: AppColors.appBlackColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }),
                        const SizedBox(height: 10.0),
                        Expanded(
                          flex: 5,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: ApiRequests.getInCartProducts(_userID),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                if (snapshot.data!.size == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Your shopping cart is empty",
                                          style: TextStyle(
                                            color: AppColors.appBlackColor,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Be inspired and discover something new to renew your closet",
                                          style: TextStyle(
                                            color: AppColors.appGreyColor,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        PrimaryButton(
                                          title: "Continue Shopping",
                                          buttonColor: AppColors.appBlueColor,
                                          onPressed: () =>
                                              pageController.jumpToPage(0),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                ShoppingCartModal _shoppingCart =
                                    ShoppingCartModal.fromJson(
                                        snapshot.data!.docs.first.data()
                                            as Map<String, dynamic>);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _shoppingCart.products.length,
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Product _product =
                                        _shoppingCart.products[index];
                                    return FutureBuilder(
                                      future: ApiRequests.getProduct(
                                          _product.productId),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        ProductModal _prod =
                                            snapshot.data as ProductModal;
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Image.network(
                                                    '${_prod.images.first.src}',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Text(
                                                        "${_prod.name}",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: AppColors
                                                              .appBlackColor,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 2.5),
                                                      Text(
                                                        "${_prod.description}",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: AppColors
                                                              .appGreyColor,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .appBlueColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 10.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (_shoppingCart
                                                                            .products[index]
                                                                            .productQuantity !=
                                                                        1)
                                                                      _decrementProductQuantity(
                                                                        _shoppingCart
                                                                            .products[index]
                                                                            .productId,
                                                                      );
                                                                    else
                                                                      _removeProductFromUserCart(_shoppingCart
                                                                          .products[
                                                                              index]
                                                                          .productId);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .minus,
                                                                    size: 16.0,
                                                                    color: AppColors
                                                                        .appWhiteColor,
                                                                  ),
                                                                ),
                                                                _isQuantityLoading
                                                                    ? Center(
                                                                        child:
                                                                            CupertinoActivityIndicator(),
                                                                      )
                                                                    : Text(
                                                                        '${_shoppingCart.products[index].productQuantity}',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.appWhiteColor,
                                                                          fontSize:
                                                                              18.0,
                                                                        ),
                                                                      ),
                                                                InkWell(
                                                                  onTap: () =>
                                                                      _incrementProductQuantity(
                                                                    _shoppingCart
                                                                        .products[
                                                                            index]
                                                                        .productId,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 16.0,
                                                                    color: AppColors
                                                                        .appWhiteColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'AED ${(double.parse(_prod.price)) * (_shoppingCart.products[index].productQuantity)}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                color: AppColors
                                                                    .appBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
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
                                              thickness: 0.5,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              }),
                        ),
                        Expanded(
                          flex: 2,
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
                _isSubTotalLoading
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : Text(
                        "AED $_subTotal",
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
                    onTap: () => pageController.jumpToPage(0),
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
                  child: InkWell(
                    onTap: () => _processOrder(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: _isSubTotalLoading && _isOrderProcessing
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Text(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _processOrder() async {
    if (_subTotal == 0)
      Common.showErrorTopSnack(
          context, "Add products to cart before proceeding");
    if (!(_isSubTotalLoading || _isOrderProcessing) &&
        (_shoppingCart != null)) {
      Common.push(
        context,
        Checkout(
          subTotal: _subTotal,
          shoppingCart: _shoppingCart!,
        ),
      );
    }
  }
}

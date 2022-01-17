import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class ProductDetail extends StatefulWidget {
  final ProductModal product;
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int purchaseItemCount = 1;
  String _userID = "";
  bool _isLoading = true, _isWishListLoading = true;
  bool _isProductWishListed = false;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _getUser() async {
    int _id = await getInt(Common.ID);
    _userID = _id.toString();
    _toggleLoading();

    await _getWishListDetails();
  }

  Future<void> _getWishListDetails() async {
    _isProductWishListed = await ApiRequests.getWishlistProduct(
        widget.product.id.toString(), _userID);

    _toggleWishListLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        child: Image.network(
                          '${widget.product.images.first.src}',
                          fit: BoxFit.fill,
                          height: 350.0,
                        ),
                      ),
                      Positioned(
                        top: 20.0,
                        left: 20.0,
                        child: InkWell(
                          onTap: () => Common.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.appWhiteColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.appGreyColor.withOpacity(0.4),
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(1, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.appWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 5.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.product.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0,
                                  height: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            InkWell(
                              onTap: () => _processWishListProduct(),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.appGreyColor
                                          .withOpacity(0.3),
                                      offset: Offset(1, 2),
                                      spreadRadius: 5.0,
                                      blurRadius: 12.0,
                                    ),
                                  ],
                                ),
                                child: _isWishListLoading
                                    ? CupertinoActivityIndicator()
                                    : Icon(
                                        _isProductWishListed
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 26.0,
                                        color: _isProductWishListed
                                            ? AppColors.appBlueColor
                                            : AppColors.appGreyColor,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90.0,
                              decoration: BoxDecoration(
                                color: AppColors.appBlueColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (purchaseItemCount != 1)
                                        purchaseItemCount--;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10.0,
                                        6.0,
                                        0.0,
                                        6.0,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$purchaseItemCount',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (!(purchaseItemCount >= 9))
                                        purchaseItemCount++;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        0.0,
                                        6.0,
                                        10.0,
                                        6.0,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                widget.product.onSale
                                    ? Text(
                                        'AED ${widget.product.regularPrice}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MontserratBlack',
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 22.0,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Text(
                                  'AED ${widget.product.price}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MontserratBlack',
                                    fontSize: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '${widget.product.description}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _isLoading ? LoadingOverlay() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.appWhiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.appGreyColor.withOpacity(0.2),
              offset: Offset(1, 2),
              spreadRadius: 10.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Common.pushAndRemoveUntil(context, Dashboard()),
                child: Text(
                  'CONTINUE EXPLORING',
                  style: TextStyle(
                    color: AppColors.appBlueColor,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'MontserratBlack',
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _processAddToCart(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      color: AppColors.appWhiteColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratBlack',
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLoading({bool? isLoading}) {
    _isLoading = isLoading ?? !_isLoading;
    setState(() {});
  }

  void _toggleWishListLoading({bool? isLoading}) {
    _isWishListLoading = isLoading ?? !_isWishListLoading;
    setState(() {});
  }

  void _processWishListProduct() async {
    if (!_isWishListLoading) {
      _toggleWishListLoading();
      await ApiRequests.toggleProductWishList(
          _isProductWishListed, _userID.toString(), widget.product);
      _getWishListDetails();
    }
  }

  void _processAddToCart() async {
    _toggleLoading(isLoading: true);

    if (_isLoading) {
      await ApiRequests.processAddProductToCart(
        widget.product.id.toString(),
        purchaseItemCount,
        _userID,
        variation: widget.product.variations.length == 0
            ? 0
            : widget.product.variations.first,
        context: context,
      );
      Common.showSuccessTopSnack(
          context, "Product Added to Cart Successfully!");
    }

    _toggleLoading();
  }
}

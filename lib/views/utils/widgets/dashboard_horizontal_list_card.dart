import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import '../../../cart_provider.dart';

class DashboardHorizontalListCard extends StatefulWidget {
  final ProductModal product;
  final bool? isLocal;
  final double? width;
  final VoidCallback? onPressed;

  const DashboardHorizontalListCard({
    Key? key,
    required this.product,
    this.isLocal = false,
    this.width,
    this.onPressed,
  }) : super(key: key);

  @override
  State<DashboardHorizontalListCard> createState() =>
      _DashboardHorizontalListCardState();
}

class _DashboardHorizontalListCardState
    extends State<DashboardHorizontalListCard> {
  bool _isWishListLoading = true;
  bool _isAddToCartLoading = false;
  bool _isProductWishListed = false;
  int _userID = 0;

  @override
  void initState() {
    _getWishListDetails();
    super.initState();
  }

  void _getWishListDetails() async {
    _userID = await getInt(Common.ID);
    _isProductWishListed = await ApiRequests.getWishlistProduct(
        widget.product.id.toString(), _userID.toString());

    _toggleWishListLoading();
  }

  void _toggleWishListLoading() {
    _isWishListLoading = !_isWishListLoading;
    setState(() {});
  }

  void _toggleCartLoading() {
    _isAddToCartLoading = !_isAddToCartLoading;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed ??
              () =>
              Common.push(
                context,
                ProductDetail(product: widget.product),
              ),
      child: Container(
        width: widget.width,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: widget.product.images.length != 0
                          ? Image.network(
                        "${widget.product.images.first.src}",
                        fit: BoxFit.fill,
                      )
                          : Image.asset(
                          "${Common.assetsImages}demo_product.png"),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: InkWell(
                      onTap: () => _processWishListProduct(),
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
                  ),
                  Visibility(
                    visible: widget.product.onSale == true,
                    child: Positioned(
                      top: 90.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
                          child: Text(
                            'onSale',
                            style: TextStyle(color: AppColors.appWhiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.product.variations.isEmpty,
                    child: Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: InkWell(
                          onTap: () => _processAddToCart(),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.appWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appBlackColor.withOpacity(
                                      0.1),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(6.0),
                            child: _isAddToCartLoading
                                ? CupertinoActivityIndicator()
                                : Icon(
                              Icons.shopping_cart,
                              size: 26.0,
                              color: AppColors.appBlueColor,
                            ),
                          ),
                        )),
                  )
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
                    "${widget.product.name}",
                    style: GoogleFonts.montserrat(
                      color: AppColors.appBlueColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                        widget.product.salePrice.isNotEmpty
                            ? Text(
                          "AED ${widget.product.regularPrice}",
                          style: GoogleFonts.poppins(
                            color: AppColors.appBlueColor.withOpacity(0.5),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "AED ${widget.product.price}",
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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

  void _processWishListProduct() async {
    if (!_isWishListLoading) {
      _toggleWishListLoading();
      await ApiRequests.toggleProductWishList(
          _isProductWishListed, _userID.toString(), widget.product);
      _getWishListDetails();
    }
  }

  void _processAddToCart() async {
    _toggleCartLoading();
    await ApiRequests.processAddProductToCart(
      widget.product.id.toString(),
      1,
      _userID.toString(),
      variation: 0,
      context: context,
    );

    Common.showSuccessTopSnack(
        context, "Product Added to Cart Successfully!");
    _toggleCartLoading();
  }
}






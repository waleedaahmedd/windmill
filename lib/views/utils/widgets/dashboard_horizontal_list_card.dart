import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed ??
          () => Common.push(
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
                      color: AppColors.appBlackColor.withOpacity(0.8),
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: -10,
                          children: [
                            widget.product.salePrice.isNotEmpty
                                ? Text(
                                    "AED ${widget.product.regularPrice}",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.appBlackColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Text(
                              "AED ${widget.product.price}",
                              style: GoogleFonts.poppins(
                                color: AppColors.appBlackColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
}

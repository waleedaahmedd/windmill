import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class ProductFavouriteCard extends StatefulWidget {

  final ProductModal product;
  final String userID;
  final VoidCallback? onPressed;

  const ProductFavouriteCard({Key? key,required this.product,
    required this.userID,
    this.onPressed,}) : super(key: key);


  @override
  _ProductFavouriteCardState createState() => _ProductFavouriteCardState();
}

class _ProductFavouriteCardState extends State<ProductFavouriteCard> {

  bool _isAddToCartLoading = false;


  void _toggleCartLoading() {
    _isAddToCartLoading = !_isAddToCartLoading;
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
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: widget.product.images.length != 0
                        ? Image.network(
                      "${widget.product.images.first.src}",
                      fit: BoxFit.fill,
                    )
                        : Image.asset("${Common.assetsImages}demo_product.png"),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.name}',
                        style: GoogleFonts.montserrat(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appBlackColor,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "AED ${widget.product.price}",
                        style: GoogleFonts.montserrat(
                          color: AppColors.appBlackColor,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: InkWell(
              onTap: () =>
                  ApiRequests.toggleProductWishList(true, widget.userID, widget.product),
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
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.favorite,
                  size: 22.0,
                  color: AppColors.appBlueColor,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.product.variations.isEmpty,
            child: Positioned(
                top: 10.0,
                right: 10.0,
                child: InkWell(
                  onTap: () => _processAddToCart(context),
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
    );
  }

  void _processAddToCart(BuildContext context) async {
    _toggleCartLoading();
    await ApiRequests.processAddProductToCart(
      widget.product.id.toString(),
      1,
      widget.userID.toString(),
      variation: 0,
      context: context,
    );

    Common.showSuccessTopSnack(
        context, "Product Added to Cart Successfully!");
    _toggleCartLoading();
  }
}


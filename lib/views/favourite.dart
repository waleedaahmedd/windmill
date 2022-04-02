import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool _isLoading = false;
  String _userID = ""; // assigning value ins inside init

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindmillAppBar(
            appBarColor: AppColors.appBlueColor,
            needBackIcon: Navigator.of(context).canPop(),
            title: "Favourite",
            titleTS: TextStyle(
              color: AppColors.appWhiteColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20.0),
          _isLoading
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ApiRequests.getWishListItems(_userID),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your wishlist is empty",
                                style: TextStyle(
                                  color: AppColors.appBlackColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Save your favorite items so you don't lose sight of them",
                                style: TextStyle(
                                  color: AppColors.appGreyColor,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              PrimaryButton(
                                title: "Be inspired by the latest",
                                buttonColor: AppColors.appBlueColor,
                                onPressed: () => pageController.jumpToPage(0),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot favouriteItemDocument =
                              snapshot.data!.docs[index];
                          String _productID = (favouriteItemDocument.data()
                              as Map<String, dynamic>)['product_id'];
                          return FutureBuilder(
                            future: ApiRequests.getProduct(_productID),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              ProductModal _product =
                                  snapshot.data as ProductModal;
                              return Column(
                                children: [
                                  ProductFavouriteCard(
                                    product: _product,
                                    userID: _userID,
                                  ),
                                  Divider(
                                      color: Colors.black
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _getUser() async {
    int _id = await getInt(Common.ID);
    _userID = _id.toString();

    _isLoading = false;
    setState(() {});
  }
}

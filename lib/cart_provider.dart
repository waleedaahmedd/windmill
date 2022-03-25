import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:windmill_general_trading/views/utils/api_requests/api_requests.dart';
import 'package:windmill_general_trading/views/utils/common.dart';
import 'package:windmill_general_trading/views/utils/shared_pref.dart';

class CartProvider with ChangeNotifier {
  int cartCount = 0;
  String? _userID;
  final firestoreInstance = FirebaseFirestore.instance;

  addCartCount() {
    this.cartCount = cartCount++;
    notifyListeners();
  }

  setCartCount(int count) {
    this.cartCount = count;
    notifyListeners();
  }

  Future<dynamic> getCartProducts(BuildContext context) async {
    int _id = await getInt(Common.ID);
    _userID = _id.toString();

    final checkCart = await ApiRequests.userHaveShoppingCart(_userID!);

    if (checkCart) {
      await ApiRequests.getInCartProductsNew(_userID!, context);
    }
  }

  Future<dynamic> addCartProducts(BuildContext context, String productID, int quantity, int variation) async {

    final reponse = await ApiRequests.addProductToCart( productID, quantity, variation, '$_userID');



  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class ApiRequests {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static var header = {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
  };

  static Future<LoginModal> googleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      return await loginUser(context, googleSignInAccount!.email,
          isSocialLogin: true);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  static facebookLogin(BuildContext context) async {
    try {
      FacebookLogin facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      print(result.status);
      if (result.status == FacebookLoginStatus.success) {
        final profile = await facebookLogin.getUserProfile();
        final email = await facebookLogin.getUserEmail();
        final firstName = profile?.firstName;
        final lastName = profile?.lastName;
        return await loginUser(context, email!, isSocialLogin: true);
      }
    } catch (e) {
      throw (e);
    }
  }

  static Future<List<ProductModal>> getProducts(
      {required String orderBy, String order = Common.DESC}) async {
    try {
      return await Dio()
          .get(
        Common.API_URL +
            "products?orderby=$orderBy&order=$order&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}",
        options: Options(headers: header),
      )
          .then((value) {
        List<ProductModal> _products = [];
        value.data.forEach((product) {
          _products.add(ProductModal.fromJson(product));
        });
        return _products;
      });
    } on DioError catch (e) {
      print(e);
      return <ProductModal>[];
    }
  }

  static Future<bool> getWishlistProduct(
      String productID, String userID) async {
    bool _isProductWishListed = false;
    await _firebaseFirestore
        .collection(Common.WISHLISTS)
        .where("user_id", isEqualTo: userID)
        .where("product_id", isEqualTo: productID)
        .get()
        .then((value) {
      _isProductWishListed = value.docs.length == 0 ? false : true;
    });
    return _isProductWishListed;
  }

  static Future<void> toggleProductWishList(
      bool isProductWishListed, String userID, ProductModal product) async {
    if (isProductWishListed)
      await _firebaseFirestore
          .collection(Common.WISHLISTS)
          .where("user_id", isEqualTo: userID)
          .where("product_id", isEqualTo: product.id.toString())
          .get()
          .then((value) async {
        print(value.docs.length);
        String _wishListID = value.docs.first.data()['id'];
        await _firebaseFirestore
            .collection(Common.WISHLISTS)
            .doc(_wishListID)
            .delete();
      });
    else {
      DocumentReference wishListReference =
          _firebaseFirestore.collection(Common.WISHLISTS).doc();
      await wishListReference.set({
        "id": wishListReference.id,
        "user_id": userID,
        "product_id": product.id.toString(),
        "created_at": Timestamp.now()
      });
    }
  }

  static getWishListItems(String userID) {
    return _firebaseFirestore
        .collection(Common.WISHLISTS)
        .where("user_id", isEqualTo: userID)
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  static Future<ProductModal> getProduct(String id) async {
    String url = Common.API_URL +
        "products/$id?consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    print(url);
    try {
      return await Dio()
          .get(
            url,
            options: Options(headers: header),
          )
          .then(
            (value) => ProductModal.fromJson(value.data),
          );
    } on DioError catch (e) {
      print(e);
      return ProductModal.fromJson(e.response!.data);
    }
  }

  static Future<List<Category>> getAllCategories() async {
    String url = Common.API_URL +
        "products/categories?per_page=100&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    print(url);
    try {
      return await Dio()
          .get(
        url,
        options: Options(headers: header),
      )
          .then((value) {
        List<Category> _categories = [];
        value.data.forEach((category) {
          _categories.add(Category.fromJson(category));
        });
        return _categories;
      });
    } on DioError catch (e) {
      print(e);
      return <Category>[];
    }
  }

  static Future<List<Category>> getCategory(int categoryId) async {
    String url = Common.API_URL +
        "products/categories=$categoryId?consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    print(url);
    try {
      return await Dio()
          .get(
        url,
        options: Options(headers: header),
      )
          .then((value) {
        List<Category> _categories = [];
        value.data.forEach((category) {
          _categories.add(Category.fromJson(category));
        });
        return _categories;
      });
    } on DioError catch (e) {
      print(e);
      return <Category>[];
    }
  }

  static Future<List<ProductModal>> getProductsByCategory({
    required int category,
    String? orderBy,
    String? order = Common.DESC,
    String? categories,
  }) async {
    String url = "";
    if(categories != null)
      url = Common.API_URL +
          "products?categories=$categories&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    else
      url = (orderBy == null || orderBy == Common.RECOMMENDED)
          ? Common.API_URL +
          "products?category=$category&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}"
          : (orderBy == Common.DISCOUNT)
          ? Common.API_URL +
          "products?category=$category&$orderBy&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}"
          : Common.API_URL +
          "products?category=$category&orderby=$orderBy&order=$order&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    print(url);
    try {
      return await Dio()
          .get(
        url,
        options: Options(headers: header),
      )
          .then((value) {
        List<ProductModal> _products = [];
        value.data.forEach((product) {
          _products.add(ProductModal.fromJson(product));
        });
        return _products;
      });
    } on DioError catch (e) {
      print(e);
      return <ProductModal>[];
    }
  }

  static Future<LoginModal> loginUser(BuildContext context, String email,
      {String? uid, bool isSocialLogin = false}) async {
    try {
      var data;
      if (isSocialLogin) {
        data = {
          "username": email,
          "social_login": isSocialLogin,
        };
      } else {
        data = {
          "username": email,
          "password": uid,
        };
      }
      return await Dio()
          .post(
        Common.BASE_URL + "jwt-auth/v1/token",
        options: Options(headers: header),
        data: data,
      )
          .then((value) async {
        LoginModal _login = LoginModal.fromJson(value.data);
        await updateDeviceToken(_login.data!.id);
        return _login;
      });
    } on DioError catch (e) {
      print(e);
      return LoginModal(
        message: '${e.toString()}',
        success: false,
        statusCode: e.response!.statusCode!,
        code: 'error',
      );
    }
  }

  static Future<UserModal> getUser(String userID) async {
    try {
      return await Dio()
          .post(
        Common.API_URL +
            "customers/$userID?consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}",
        options: Options(headers: header),
      )
          .then((value) {
        print(value.data);
        return UserModal.fromJson(value.data);
      });
    } on DioError catch (e) {
      return UserModal.fromJson(e.response!.data);
    }
  }

  static Future<RegisterModal> registerUser(
      BuildContext context, request) async {
    try {
      return await Dio()
          .post(
            Common.API_URL +
                "customers?consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}",
            options: Options(headers: header),
            data: request,
          )
          .then((value) => RegisterModal.fromJson(value.data));
    } on DioError catch (e) {
      return RegisterModal.fromJson(e.response!.data);
    }
  }

  static Future<bool> placeOrder(OrderModal order) async {
    try {
      String _token = await getString(Common.TOKEN);
      header = {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        HttpHeaders.authorizationHeader: "Basic $_token",
        HttpHeaders.contentTypeHeader: "application/json",
      };
      return await Dio()
          .post(
        Common.API_URL +
            "orders?consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}",
        data: order.toJson(),
        options: Options(headers: header),
      )
          .then((value) {
        print(value);
        return true;
      });
    } on DioError catch (e) {
      return false;
    }
  }

  static Future<List<OrderResponseModal>> getOrders(
      String userID, String role) async {
    print(role);
    String url = "";
    if (role == Common.DRIVER)
      url = Common.API_URL +
          "orders?driver=$userID&status=${Common.DRIVER_ASSIGNED}&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    else
      url = Common.API_URL +
          "orders?customer=$userID&consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    print(url);
    try {
      return await Dio()
          .get(
            url,
            options: Options(headers: header),
          )
          .then((value) => (value.data as List)
              .map((e) => OrderResponseModal.fromJson(e))
              .toList());
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> isProductInCart(String productID, String userID) async {
    bool _isItemInCart = false;
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((shoppingCart) {
        ShoppingCartModal _shoppingCart =
            ShoppingCartModal.fromJson(shoppingCart.data());
        _shoppingCart.products.forEach((product) {
          _isItemInCart = product.productId == productID;
        });
      });
    });
    return _isItemInCart;
  }

  static Future<void> addProductToCart(
      String productID, int quantity, int variation, String userID) async {
    DocumentReference shoppingCartReference =
        _firebaseFirestore.collection(Common.SHOPPING_CART).doc();
    Product _product = new Product(
      productId: productID,
      productQuantity: quantity,
      productVariation: variation,
    );
    List<Product> _products = [];
    _products.add(_product);
    ShoppingCartModal shoppingCartModal = new ShoppingCartModal(
      id: shoppingCartReference.id,
      userId: userID,
      lastActivityAt: Timestamp.now(),
      products: _products,
    );
    await shoppingCartReference.set(shoppingCartModal.toJson());
  }

  static Future<void> updateInCartProduct(
    String productID,
    String userID,
    int newQuantity, {
    required bool needIncrementOnQuantity,
    required bool needDecrementOnQuantity,
  }) async {
    String _shoppingCartID = "";
    late ShoppingCartModal _shoppingCart;
    int _quantity = newQuantity;
    int _variation = 0;
    List<Product> _updatedList = [];
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((shoppingCart) {
        _shoppingCart = ShoppingCartModal.fromJson(shoppingCart.data());
        _shoppingCartID = _shoppingCart.id;
        _shoppingCart.products.forEach((product) {
          if (product.productId != productID)
            _updatedList.add(product);
          else {
            _variation = product.productVariation;
            if (needIncrementOnQuantity)
              _quantity += product.productQuantity;
            else if (needDecrementOnQuantity)
              _quantity = product.productQuantity - 1;
          }
        });
      });
    });
    Product _product = new Product(
      productId: productID,
      productQuantity: _quantity,
      productVariation: _variation,
    );
    _updatedList.add(_product);
    _shoppingCart.products = _updatedList;
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .doc(_shoppingCartID)
        .update(_shoppingCart.toJson());
  }

  static Future<void> processAddProductToCart(
    String productID,
    int quantity,
    String userID, {
    required BuildContext context,
    int? variation,
    bool needIncrementOnQuantity = true,
    bool needDecrementOnQuantity = false,
  }) async {
    // check if item is already in cart or not
    if (await isProductInCart(productID, userID)) {
      // if item in cart then add quantity with sum of previous quantity
      if (needIncrementOnQuantity)
        await updateInCartProduct(
          productID,
          userID,
          quantity,
          needIncrementOnQuantity: true,
          needDecrementOnQuantity: false,
        );
      else if (needDecrementOnQuantity)
        await updateInCartProduct(
          productID,
          userID,
          quantity,
          needDecrementOnQuantity: true,
          needIncrementOnQuantity: false,
        );
      else
        await updateInCartProduct(
          productID,
          userID,
          quantity,
          needDecrementOnQuantity: false,
          needIncrementOnQuantity: false,
        );
    } else if (await userHaveShoppingCart(userID)) {
      await updateInCartProduct(
        productID,
        userID,
        quantity,
        needDecrementOnQuantity: false,
        needIncrementOnQuantity: false,
      );
    } else {
      // if item not in cart then add quantity only
      await addProductToCart(productID, quantity, variation!, userID);
    }
  }

  static getInCartProducts(String userID) {
    return _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .snapshots();
  }

  static Future<bool> userHaveShoppingCart(String userID) async {
    bool _isCartAvailable = false;
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .get()
        .then((value) {
      _isCartAvailable = value.docs.length != 0;
    });
    return _isCartAvailable;
  }

  static Future<void> removeItemFromShoppingCart(
      String userID, String productID) async {
    String _shoppingCartID = "";
    late ShoppingCartModal _shoppingCart;
    List<Product> _updatedList = [];
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((shoppingCart) {
        _shoppingCart = ShoppingCartModal.fromJson(shoppingCart.data());
        _shoppingCartID = _shoppingCart.id;
        _shoppingCart.products.forEach((product) {
          if (product.productId != productID) _updatedList.add(product);
        });
      });
    });
    _shoppingCart.products = _updatedList;
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .doc(_shoppingCartID)
        .update(_shoppingCart.toJson());
  }

  static Future<double> getSubTotalForShoppingCart(String userID) async {
    double _subTotal = 0.0;
    late ShoppingCartModal _shoppingCart;
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .get()
        .then((value) async {
      for (var shoppingCart in value.docs) {
        _shoppingCart = ShoppingCartModal.fromJson(shoppingCart.data());
        for (var product in _shoppingCart.products) {
          ProductModal _product = await getProduct(product.productId);
          _subTotal += (double.parse(_product.price) * product.productQuantity);
        }
      }
    });
    return _subTotal;
  }

  static Future<void> deleteUserShoppingCart(String userID) async {
    await _firebaseFirestore
        .collection(Common.SHOPPING_CART)
        .where("user_id", isEqualTo: userID)
        .orderBy("last_activity_at", descending: true)
        .get()
        .then((value) async {
      for (var shoppingCart in value.docs) {
        ShoppingCartModal _cart =
            ShoppingCartModal.fromJson(shoppingCart.data());
        print(_cart.id);
        await _firebaseFirestore
            .collection(Common.SHOPPING_CART)
            .doc(_cart.id)
            .delete();
      }
    });
  }

  static Future<void> markOrderAsCompleted(
    OrderResponseModal order,
    UserModal user, {
    bool shouldSendNotification = true,
    bool isCodOrder = true,
    bool displaySuccessMessage = true,
    required BuildContext context,
  }) async {
    var data;

    // params set_paid = isCodOrder and status = completed
    if (isCodOrder)
      data = {
        "status": "completed",
        "set_paid": isCodOrder,
      };
    else
      data = {
        "status": "completed",
      };

    String url = Common.API_URL +
        "orders/${order.id}?consumer_key=${Common.CONSUMER_KEY}&consumer_secret=${Common.CONSUMER_SECRET}";
    print(url);
    // mark order as completed and paid if order was COD
    try {
      return await Dio()
          .put(
        url,
        data: data,
        options: Options(headers: header),
      )
          .then((value) async {
        // send notification to ordering user that order is completed successfully
        if (shouldSendNotification)
          await sendNotification(
            order.customerID,
            "Order has been delivered.",
            "${user.firstName} delivered your order. Thank you for shopping with us, we hope to see you again ordering from us.",
          );

        if (displaySuccessMessage)
          Common.showSuccessTopSnack(context, "Order Completed Successfully.");
        return Future.value(null);
      });
    } on DioError catch (e) {
      print(e);
      return;
    }
  }

  static Future<void> updateDeviceToken(int userID) async {
    FirebaseMessaging _fM = FirebaseMessaging.instance;
    await _firebaseFirestore
        .collection(Common.USERS)
        .doc(userID.toString())
        .set({
      "id": userID,
      "device_token": await _fM.getToken(),
    });
    return;
  }

  static Future<void> deleteDeviceToken(String userID) async {
    await _firebaseFirestore.collection(Common.USERS).doc(userID).update({
      "device_token": FieldValue.delete(),
    });
    return;
  }

  static Future<void> sendNotification(
    int notificationReceiverID,
    String notificationTitle,
    String notificationBody,
  ) async {
    // make collection in firebase and deliver notification to receiver.
    // at login time take user information and add id/token to firebase collection. once user logs out delete the token.
    DocumentReference notificationsReference =
        _firebaseFirestore.collection(Common.NOTIFICATIONS).doc();
    NotificationsModal notificationsModal = new NotificationsModal(
      id: notificationsReference.id,
      userId: notificationReceiverID.toString(),
      message: notificationBody,
      title: notificationTitle,
      createdOn: Timestamp.now(),
    );

    notificationsReference.set(notificationsModal.toJson());
    return;
  }
}

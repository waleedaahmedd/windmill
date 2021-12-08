import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ShoppingCartModal shoppingCartFromJson(String str) =>
    ShoppingCartModal.fromJson(json.decode(str));

String shoppingCartToJson(ShoppingCartModal data) => json.encode(data.toJson());

class ShoppingCartModal {
  ShoppingCartModal({
    required this.id,
    required this.userId,
    required this.lastActivityAt,
    required this.products,
  });

  String id;
  String userId;
  Timestamp lastActivityAt;
  List<Product> products;

  factory ShoppingCartModal.fromJson(Map<String, dynamic> json) =>
      ShoppingCartModal(
        id: json["id"],
        userId: json["user_id"],
        lastActivityAt: json["last_activity_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "last_activity_at": lastActivityAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.productId,
    required this.productQuantity,
    required this.productVariation,
  });

  String productId;
  int productQuantity;
  int productVariation;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productQuantity: json["product_quantity"],
        productVariation: json["product_variation"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_quantity": productQuantity,
        "product_variation": productVariation,
      };
}

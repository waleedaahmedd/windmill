// To parse this JSON data, do
//
//     final productModal = productModalFromJson(jsonString);
//
import 'dart:convert';

ProductModal productModalFromJson(String str) =>
    ProductModal.fromJson(json.decode(str));

String productModalToJson(ProductModal data) => json.encode(data.toJson());

class ProductModal {
  ProductModal({
    required this.id,
    required this.name,
    required this.dateCreated,
    required this.description,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.totalSales,
    required this.weight,
    required this.dimensions,
    required this.categories,
    required this.images,
    required this.attributes,
    required this.variations,
    required this.relatedIds,
  });

  int id;
  String name;
  DateTime dateCreated;
  String description;
  String price;
  String regularPrice;
  String salePrice;
  bool onSale;
  int totalSales;
  String weight;
  Dimensions dimensions;
  List<CategoryModal> categories;
  List<ImageModal> images;
  List<Attribute> attributes;
  List<int> variations;
  List<int> relatedIds;

  factory ProductModal.fromJson(Map<String, dynamic> json) => ProductModal(
        id: json["id"],
        name: json["name"],
        dateCreated: DateTime.parse(json["date_created"]),
        description: json["description"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        totalSales: json["total_sales"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        categories: List<CategoryModal>.from(
            json["categories"].map((x) => CategoryModal.fromJson(x))),
        images: List<ImageModal>.from(
            json["images"].map((x) => ImageModal.fromJson(x))),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        variations: List<int>.from(json["variations"].map((x) => x)),
        relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_created": dateCreated.toIso8601String(),
        "description": description,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "on_sale": onSale,
        "total_sales": totalSales,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
      };
}

class Attribute {
  Attribute({
    required this.id,
    required this.name,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  int id;
  String name;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

class Dimensions {
  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  String length;
  String width;
  String height;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
      };
}

class CategoryModal {
  CategoryModal({
    required this.id,
    required this.name,
    required this.slug,
  });

  int id;
  String name;
  String slug;

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class ImageModal {
  ImageModal({
    required this.id,
    required this.src,
    required this.name,
  });

  int id;
  String src;
  String name;

  factory ImageModal.fromJson(Map<String, dynamic> json) => ImageModal(
        id: json["id"],
        src: json["src"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "name": name,
      };
}

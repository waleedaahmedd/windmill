import 'dart:convert';

OrderModal orderModalFromJson(String str) =>
    OrderModal.fromJson(json.decode(str));

String orderModalToJson(OrderModal data) => json.encode(data.toJson());

class OrderModal {
  OrderModal({
    this.orderID,
    required this.customerID,
    required this.note,
    required this.orderStatus,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.setPaid,
    required this.billing,
    required this.shipping,
    required this.lineItems,
    required this.shippingLines,
  });

  int? orderID;
  String customerID;
  String note;
  String orderStatus;
  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  Ing billing;
  Ing shipping;
  List<LineItem> lineItems;
  List<ShippingLine> shippingLines;

  factory OrderModal.fromJson(Map<String, dynamic> json) => OrderModal(
        orderID: json["id"],
        customerID: json["customer_id"],
        note: json["customer_note"],
        orderStatus: json["status"],
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        setPaid: json["set_paid"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        shippingLines: List<ShippingLine>.from(
            json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": orderID,
        "customer_id": customerID,
        "customer_note": note,
        "status": orderStatus,
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "set_paid": setPaid,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "shipping_lines":
            List<dynamic>.from(shippingLines.map((x) => x.toJson())),
      };
}

class Ing {
  Ing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone,
      };
}

class LineItem {
  LineItem({
    required this.productId,
    required this.variationId,
    required this.quantity,
  });

  int productId;
  int variationId;
  int quantity;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
      };
}

class ShippingLine {
  ShippingLine({
    required this.methodId,
    required this.methodTitle,
    required this.total,
  });

  String methodId;
  String methodTitle;
  String total;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        methodId: json["method_id"],
        methodTitle: json["method_title"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "method_title": methodTitle,
        "total": total,
      };
}

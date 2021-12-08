import 'dart:convert';

OrderResponseModal orderResponseModalFromJson(String str) =>
    OrderResponseModal.fromJson(json.decode(str));

String orderResponseModalToJson(OrderResponseModal data) =>
    json.encode(data.toJson());

class OrderResponseModal {
  OrderResponseModal({
    required this.id,
    required this.customerID,
    required this.status,
    required this.dateModified,
    required this.total,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.customerNote,
    required this.lineItems,
    this.orderPaidDateTime,
  });

  int id;
  int customerID;
  String status;
  DateTime dateModified;
  String total;
  String orderKey;
  Ingg billing;
  Ingg shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String customerNote;
  List<LineItemm> lineItems;
  DateTime? orderPaidDateTime;

  factory OrderResponseModal.fromJson(Map<String, dynamic> json) =>
      OrderResponseModal(
        id: json["id"],
        customerID: json["customer_id"],
        status: json["status"],
        dateModified: DateTime.parse(json["date_modified"]),
        total: json["total"],
        orderKey: json["order_key"],
        billing: Ingg.fromJson(json["billing"]),
        shipping: Ingg.fromJson(json["shipping"]),
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        customerNote: json["customer_note"],
        lineItems: List<LineItemm>.from(
            json["line_items"].map((x) => LineItemm.fromJson(x))),
        orderPaidDateTime: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerID,
        "status": status,
        "date_modified": dateModified.toIso8601String(),
        "total": total,
        "order_key": orderKey,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "customer_note": customerNote,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "date_created_gmt": orderPaidDateTime == null
            ? null
            : orderPaidDateTime!.toIso8601String(),
      };
}

class Ingg {
  Ingg({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    this.email,
    required this.phone,
  });

  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String? email;
  String phone;

  factory Ingg.fromJson(Map<String, dynamic> json) => Ingg(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
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
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email == null ? null : email,
        "phone": phone,
      };
}

class LineItemm {
  LineItemm({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.price,
    this.parentName,
  });

  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  int price;
  String? parentName;

  factory LineItemm.fromJson(Map<String, dynamic> json) => LineItemm(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        price: json["price"],
        parentName: json["parent_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "price": price,
        "parent_name": parentName,
      };
}

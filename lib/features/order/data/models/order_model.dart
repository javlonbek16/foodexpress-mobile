class OrderModel {
  final String id;
  final int customerId;
  final String restaurantId;
  final String? restaurantName;
  final String? courierName;
  final DateTime? deliveryStartedAt;
  final DateTime? deliveryCompletedAt;
  final String status;
  final double totalPrice;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Product> items;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.restaurantId,
    this.restaurantName,
    this.courierName,
    this.deliveryStartedAt,
    this.deliveryCompletedAt,
    required this.status,
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"]?.toString() ?? "",
      customerId: json["customerId"] ?? 0,
      restaurantId: json["restaurantId"]?.toString() ?? "",
      restaurantName: json["restaurantName"],
      courierName: json["courierName"],
      deliveryStartedAt: json["deliveryStartedAt"] != null ? DateTime.parse(json["deliveryStartedAt"]) : null,
      deliveryCompletedAt: json["deliveryCompletedAt"] != null ? DateTime.parse(json["deliveryCompletedAt"]) : null,
      status: json["status"] ?? "",
      totalPrice: json["totalPrice"] ?? 0,
      currency: json["currency"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      items: (json["items"] as List<dynamic>?)?.map((e) => Product.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "customerId": customerId,
      "restaurantId": restaurantId,
      "restaurantName": restaurantName,
      "courierName": courierName,
      "deliveryStartedAt": deliveryStartedAt?.toIso8601String(),
      "deliveryCompletedAt": deliveryCompletedAt?.toIso8601String(),
      "status": status,
      "totalPrice": totalPrice,
      "currency": currency,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}

class Product {
  final String id;
  final int menuItemId;
  final String name;
  final int qty;
  final double price;
  final String? imgUrl;

  Product({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.qty,
    required this.price,
    this.imgUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"]?.toString() ?? "",
      menuItemId: json["menuItemId"] ?? 0,
      name: json["name"] ?? "",
      qty: json["qty"] ?? 0,
      price: json["price"] ?? 0,
      imgUrl: json["imgUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "menuItemId": menuItemId, "name": name, "qty": qty, "price": price, "imgUrl": imgUrl};
  }
}

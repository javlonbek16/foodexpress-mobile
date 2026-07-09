class OrderModel {
  String id;
  int customerId;
  String restaurantId;
  String restaurantName;
  String courierName;
  DateTime deliveryStartedAt;
  DateTime deliveryCompletedAt;
  String status;
  int totalPrice;
  String currency;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> items;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.restaurantId,
    required this.restaurantName,
    required this.courierName,
    required this.deliveryStartedAt,
    required this.deliveryCompletedAt,
    required this.status,
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    customerId: json["customerId"],
    restaurantId: json["restaurantId"],
    restaurantName: json["restaurantName"],
    courierName: json["courierName"],
    deliveryStartedAt: DateTime.parse(json["deliveryStartedAt"]),
    deliveryCompletedAt: DateTime.parse(json["deliveryCompletedAt"]),
    status: json["status"],
    totalPrice: json["totalPrice"],
    currency: json["currency"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    items: List<Product>.from(json["items"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "restaurantId": restaurantId,
    "restaurantName": restaurantName,
    "courierName": courierName,
    "deliveryStartedAt": deliveryStartedAt.toIso8601String(),
    "deliveryCompletedAt": deliveryCompletedAt.toIso8601String(),
    "status": status,
    "totalPrice": totalPrice,
    "currency": currency,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Product {
  String id;
  int menuItemId;
  String name;
  int qty;
  int price;
  String imgUrl;

  Product({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.qty,
    required this.price,
    required this.imgUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    menuItemId: json["menuItemId"],
    name: json["name"],
    qty: json["qty"],
    price: json["price"],
    imgUrl: json["imgUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuItemId": menuItemId,
    "name": name,
    "qty": qty,
    "price": price,
    "imgUrl": imgUrl,
  };
}

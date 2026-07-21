class OrderRequestModel {
  final String restaurantId;
  final String restaurantName;
  final String currency;
  final String deliveryAddress;
  final String customerFullName;
  final List<OrderItemRequestModel> items;

  const OrderRequestModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.currency,
    required this.deliveryAddress,
    required this.customerFullName,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    "restaurantId": restaurantId,
    "restaurantName": restaurantName,
    "currency": currency,
    "deliveryAddress": deliveryAddress,
    "customerFullName": customerFullName,
    "items": items.map((e) => e.toJson()).toList(),
  };
}

class OrderItemRequestModel {
  final int menuItemId;
  final String name;
  final int quantity;
  final double price;
  final String imgUrl;

  const OrderItemRequestModel({
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imgUrl,
  });

  Map<String, dynamic> toJson() => {
    "menuItemId": menuItemId,
    "name": name,
    "qty": quantity,
    "price": price,
    "imgUrl": imgUrl,
  };
}

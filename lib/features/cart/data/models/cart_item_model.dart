class CartItemModel {
  final String menuItemId;
  final String restaurantId;
  final String name;
  final String image;
  final double price;
  final int quantity;

  const CartItemModel({
    required this.menuItemId,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      menuItemId: json["menu_item_id"],
      restaurantId: json["restaurant_id"],
      name: json["name"],
      image: json["image"],
      price: json["price"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "menu_item_id": menuItemId,
      "restaurant_id": restaurantId,
      "name": name,
      "image": image,
      "price": price,
      "quantity": quantity,
    };
  }

  CartItemModel copyWith({
    String? menuItemId,
    String? restaurantId,

    String? name,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      menuItemId: menuItemId ?? this.menuItemId,
      restaurantId: restaurantId ?? this.restaurantId,

      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

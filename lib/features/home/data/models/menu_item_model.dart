class MenuItemModel {
  final int id;
  final String restaurantId;
  final int categoryId;
  final String name;
  final String description;
  final String price;
  final String newPrice;
  final String discount;
  final bool status;
  final String promotion;
  final String imageUrl;
  final String deliveryTime;

  MenuItemModel({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.newPrice,
    required this.discount,
    required this.status,
    required this.promotion,
    required this.imageUrl,
    required this.deliveryTime,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json["id"],
      restaurantId: json["restaurant"],
      categoryId: json["category"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      newPrice: json["new_price"],
      discount: json["discount"],
      status: json["status"],
      promotion: json["promotion"],
      imageUrl: json["image_url"],
      deliveryTime: json["delivery_time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "restaurant": restaurantId,
      "category": categoryId,
      "name": name,
      "description": description,
      "price": price,
      "new_price": newPrice,
      "discount": discount,
      "status": status,
      "promotion": promotion,
      "image_url": imageUrl,
      "delivery_time": deliveryTime,
    };
  }
}

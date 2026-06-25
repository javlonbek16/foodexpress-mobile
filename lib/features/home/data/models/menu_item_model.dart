class MenuItemModel {
  final int id;
  final String restaurantId;
  final int categoryId;
  final String name;
  final String description;
  final String price;
  final String? newPrice;
  final String? discount;
  final bool status;
  final String? promotion;
  final String imageUrl;
  final String deliveryTime;

  MenuItemModel({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.newPrice,
    this.discount,
    required this.status,
    this.promotion,
    required this.imageUrl,
    required this.deliveryTime,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json["id"] as int? ?? 0,
      restaurantId: json["restaurant"]?.toString() ?? "",
      categoryId: json["category"] as int? ?? 0,
      name: json["name"]?.toString() ?? "Noma'lum taom",
      description: json["description"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "0",

      newPrice: json["new_price"]?.toString(),
      discount: json["discount"]?.toString(),

      status: json["discount_status"] == true || json["discount_status"] == "true",

      promotion: json["promotion"]?.toString(),
      imageUrl: json["img_product"]?.toString() ?? "",
      deliveryTime: json["delivery_time"]?.toString() ?? "Noma'lum vaqt",
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
      "discount_status": status,
      "promotion": promotion,
      "img_product": imageUrl,
      "delivery_time": deliveryTime,
    };
  }
}

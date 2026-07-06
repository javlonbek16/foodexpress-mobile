// To parse this JSON data, do
//
//     final categoryWithItemsModel = categoryWithItemsModelFromJson(jsonString);

import 'dart:convert';

CategoryWithItemsModel categoryWithItemsModelFromJson(String str) =>
    CategoryWithItemsModel.fromJson(json.decode(str));

String categoryWithItemsModelToJson(CategoryWithItemsModel data) => json.encode(data.toJson());

class CategoryWithItemsModel {
  int id;
  List<int> category;
  dynamic restaurantUuid;
  String name;
  String description;
  String price;
  String newPrice;
  String discount;
  bool discountStatus;
  String promotion;
  String imgProduct;
  String deliveryTime;
  List<Category> categories;

  CategoryWithItemsModel({
    required this.id,
    required this.category,
    required this.restaurantUuid,
    required this.name,
    required this.description,
    required this.price,
    required this.newPrice,
    required this.discount,
    required this.discountStatus,
    required this.promotion,
    required this.imgProduct,
    required this.deliveryTime,
    required this.categories,
  });

  CategoryWithItemsModel copyWith({
    int? id,
    List<int>? category,
    dynamic restaurantUuid,
    String? name,
    String? description,
    String? price,
    String? newPrice,
    String? discount,
    bool? discountStatus,
    String? promotion,
    String? imgProduct,
    String? deliveryTime,
    List<Category>? categories,
  }) => CategoryWithItemsModel(
    id: id ?? this.id,
    category: category ?? this.category,
    restaurantUuid: restaurantUuid ?? this.restaurantUuid,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    newPrice: newPrice ?? this.newPrice,
    discount: discount ?? this.discount,
    discountStatus: discountStatus ?? this.discountStatus,
    promotion: promotion ?? this.promotion,
    imgProduct: imgProduct ?? this.imgProduct,
    deliveryTime: deliveryTime ?? this.deliveryTime,
    categories: categories ?? this.categories,
  );

  factory CategoryWithItemsModel.fromJson(Map<String, dynamic> json) => CategoryWithItemsModel(
    id: json["id"],
    category: List<int>.from(json["category"].map((x) => x)),
    restaurantUuid: json["restaurant_uuid"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    newPrice: json["new_price"],
    discount: json["discount"],
    discountStatus: json["discount_status"],
    promotion: json["promotion"],
    imgProduct: json["img_product"],
    deliveryTime: json["delivery_time"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": List<dynamic>.from(category.map((x) => x)),
    "restaurant_uuid": restaurantUuid,
    "name": name,
    "description": description,
    "price": price,
    "new_price": newPrice,
    "discount": discount,
    "discount_status": discountStatus,
    "promotion": promotion,
    "img_product": imgProduct,
    "delivery_time": deliveryTime,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  int id;
  String restaurant;
  String name;

  Category({required this.id, required this.restaurant, required this.name});

  Category copyWith({int? id, String? restaurant, String? name}) => Category(
    id: id ?? this.id,
    restaurant: restaurant ?? this.restaurant,
    name: name ?? this.name,
  );

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["id"], restaurant: json["restaurant"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "restaurant": restaurant, "name": name};
}

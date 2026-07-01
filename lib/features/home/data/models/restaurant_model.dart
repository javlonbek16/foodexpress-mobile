class RestaurantModel {
  final String restaurantId;
  final int ownerUserId;
  final String name;
  final String description;
  final String address;
  final bool isOpen;
  final String createdAt;
  final String restaurantImage;

  const RestaurantModel({
    required this.restaurantId,
    required this.ownerUserId,
    required this.name,
    required this.description,
    required this.address,
    required this.isOpen,
    required this.createdAt,
    required this.restaurantImage,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      restaurantId: json["id"]?.toString() ?? "",
      ownerUserId: int.tryParse(json["owner_user_id"]?.toString() ?? "") ?? 0,
      name: json["name"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",
      address: json["address"]?.toString() ?? "",
      isOpen: json["is_open"] == true || json["is_open"]?.toString().toLowerCase() == "true",
      createdAt: json["created_at"]?.toString() ?? "",
      restaurantImage: json["restaurant_img"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": restaurantId,
      "owner_user_id": ownerUserId,
      "name": name,
      "description": description,
      "address": address,
      "is_open": isOpen,
      "created_at": createdAt,
      "restaurant_img": restaurantImage,
    };
  }
}

class RestaurantModel {
  final String restaurantId;
  final int ownerUserId;
  final String name;
  final String description;
  final String address;
  final bool isOpen;
  final String createdAt;
  final String restaurantImage;

  RestaurantModel({
    required this.restaurantId,
    required this.ownerUserId,
    required this.name,
    required this.description,
    required this.address,
    required this.isOpen,
    required this.createdAt,
    required this.restaurantImage
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      restaurantId: json["id"],
      ownerUserId: json["owner_user_id"],
      name: json["name"],
      description: json["description"],
      address: json["address"],
      isOpen: json["is_open"],
      createdAt: json["created_at"],
      restaurantImage: json["restaurant_img"] 
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
      "restaurant_img": restaurantImage
    };
  }
}

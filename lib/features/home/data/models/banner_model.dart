class BannerModel {
  final int id;
  final String restaurantId;
  final String imageUrl;
  final String promotion;

  const BannerModel({
    required this.id,
    required this.restaurantId,
    required this.imageUrl,
    required this.promotion,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json["id"] ?? 0,
      restaurantId: json["restaurant"]?.toString() ?? "",
      imageUrl: json["image_ads"]?.toString() ?? "",
      promotion: json["promotion"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "restaurant": restaurantId, "image_ads": imageUrl, "promotion": promotion};
  }
}

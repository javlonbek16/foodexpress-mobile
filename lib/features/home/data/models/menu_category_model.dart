class MenuCategoryModel {
  final int id;
  final String restaurantId;
  final String name;

  const MenuCategoryModel({required this.id, required this.restaurantId, required this.name});

  factory MenuCategoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const MenuCategoryModel(id: 0, restaurantId: "", name: "");
    }

    return MenuCategoryModel(
      id: int.tryParse(json["id"]?.toString() ?? '') ?? 0,
      restaurantId: json["restaurant"]?.toString() ?? '',
      name: json["name"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "restaurant": restaurantId, "name": name};
}

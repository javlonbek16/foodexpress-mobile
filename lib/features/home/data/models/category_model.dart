class CategoryModel {
  final int categoryId;
  final String restaurantId;
  final String categoryName;
  final int sortOrder;

  CategoryModel({
    required this.categoryId,
    required this.restaurantId,
    required this.categoryName,
    required this.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json["id"],
      restaurantId: json["restaurant"],
      categoryName: json["name"],
      sortOrder: json["sort_order"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": categoryId,
      "restaurant": restaurantId,
      "name": categoryName,
      "sort_order": sortOrder,
    };
  }
}

class CategoryModel {
  final int categoryId;
  final String categoryName;

  const CategoryModel({required this.categoryId, required this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: int.tryParse(json["id"]?.toString() ?? "") ?? 0,
      categoryName: json["name"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": categoryId, "name": categoryName};
  }
}

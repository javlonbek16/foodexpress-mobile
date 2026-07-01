import 'package:foodexpress_mobile/features/home/data/models/menu_category_model.dart';

class MenuItemModel {
  final int id;
  final List<MenuCategoryModel> categories;
  final String name;
  final String description;
  final String price;
  final String? newPrice;
  final String? discount;
  final bool discountStatus;
  final String? promotion;
  final String imageUrl;
  final String deliveryTime;

  const MenuItemModel({
    required this.id,
    required this.categories,
    required this.name,
    required this.description,
    required this.price,
    this.newPrice,
    this.discount,
    required this.discountStatus,
    this.promotion,
    required this.imageUrl,
    required this.deliveryTime,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const MenuItemModel(
        id: 0,
        categories: [],
        name: '',
        description: '',
        price: '0',
        newPrice: null,
        discount: null,
        discountStatus: false,
        promotion: null,
        imageUrl: '',
        deliveryTime: '',
      );
    }

    return MenuItemModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      categories:
          (json['category'] as List?)?.map((e) => MenuCategoryModel.fromJson(e)).toList() ?? [],
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      newPrice: json['new_price']?.toString(),
      discount: json['discount']?.toString(),
      discountStatus: json['discount_status'] == true,
      promotion: json['promotion']?.toString(),
      imageUrl: json['img_product']?.toString() ?? '',
      deliveryTime: json['delivery_time']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': categories.map((e) => e.toJson()).toList(),
    'name': name,
    'description': description,
    'price': price,
    'new_price': newPrice,
    'discount': discount,
    'discount_status': discountStatus,
    'promotion': promotion,
    'img_product': imageUrl,
    'delivery_time': deliveryTime,
  };
}

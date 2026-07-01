import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';

class RestaurantMenuItemModel {
  final int id;
  final String restaurantId;
  final String name;
  final List<MenuItemModel> items;

  const RestaurantMenuItemModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.items,
  });

  factory RestaurantMenuItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RestaurantMenuItemModel(id: 0, restaurantId: '', name: '', items: []);
    }

    return RestaurantMenuItemModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,

      restaurantId: json['restaurant']?.toString() ?? '',

      name: json['name']?.toString() ?? '',

      items: (json['items'] as List?)?.map((e) => MenuItemModel.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'restaurant': restaurantId,
    'name': name,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

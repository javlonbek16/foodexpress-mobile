import 'dart:convert';

import 'package:foodexpress_mobile/core/constants/app_constants.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';
import 'package:http/http.dart' as http;

class HomeRemoteDataSource {
  // final DioClient dio;

  // HomeRemoteDataSource(this.dio);

  Future<List<BannerModel>> getBanners() async {
    final response = await http.get(
      Uri.parse("${AppConstants.homeBaseUrl}/api/ads"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> decodedData = jsonDecode(response.body);

      return decodedData.map((json) => BannerModel.fromJson(json)).toList();
    } else {
      throw Exception("Bannerni olishda xatolik");
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse("${AppConstants.homeBaseUrl}/api/general-category"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> decodedData = jsonDecode(response.body);

      return decodedData.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception("Categoryni olishda xatolik!");
    }
  }

  Future<CategoryModel> getCategoryById(int id) async {
    final response = await http.get(
      Uri.parse("${AppConstants.homeBaseUrl}/api/category$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);

      return CategoryModel.fromJson(decodedData);
    } else {
      throw Exception("ID si $id ga teng bo'lgan categoryni olishda xatolik!");
    }
  }

  Future<List<MenuItemModel>> getMenuItems() async {
    final response = await http.get(
      Uri.parse("${AppConstants.homeBaseUrl}/api/menu-items"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> decodedData = jsonDecode(response.body);

      return decodedData.map((json) => MenuItemModel.fromJson(json)).toList();
    } else {
      throw Exception("Menu itemslarni olishda xatolik!");
    }
  }

  Future<MenuItemModel> getMenuItemById(int id) async {
    final response = await http.get(
      Uri.parse("${AppConstants.homeBaseUrl}/api/single-menu-items"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);

      return MenuItemModel.fromJson(decodedData);
    } else {
      throw Exception("ID si $id ga teng menu itemni olishda xatolik!");
    }
  }

  Future<List<RestaurantModel>> getRestaurants() async {
    final response = await http.get(
      Uri.parse("${AppConstants.homeBaseUrl}/api/restaurants"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> decodedData = jsonDecode(response.body);

      return decodedData.map((json) => RestaurantModel.fromJson(json)).toList();
    } else {
      throw Exception("Restaurantlarni olishda xatolik!");
    }
  }

  Future<RestaurantModel> getRestaurantById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.homeBaseUrl}/api/restaurant/$id"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);

        print("Decoded data: $decodedData");

        return RestaurantModel.fromJson(decodedData);
      } else {
        throw Exception("ID si $id ga teng restaurantni olishda xatolik!");
      }
    } catch (e, s) {
      throw Exception("Error: $e\nStacktrace: $s");
    }
  }

  Future<RestaurantMenuItemModel> getMenuItemsByRestaurant(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.homeBaseUrl}/api/restaurants/$id/menu-items"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);

        print("Decoded data: $decodedData");

        return RestaurantMenuItemModel.fromJson(decodedData);
      } else {
        throw Exception("ID si $id ga teng restaurantning menu itemini olishda xatolik!");
      }
    } catch (e, s) {
      throw Exception("Error: $e\nStacktrace: $s");
    }
  }
}

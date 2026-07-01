import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';
import 'package:foodexpress_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/food_card_widget.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String restaurantId;
  const RestaurantDetailsScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late final HomeRepository _repository;
  // late final RestaurantModel _restaurant;
  List<RestaurantMenuItemModel> _menuItems = [];

  bool _isLoading = true;
  String? _errorMessage;
  List<MenuItemModel> _foods = [];
  List<RestaurantModel> _restaurant = [];

  @override
  void initState() {
    super.initState();

    _repository = HomeRepositoryImpl(HomeRemoteDataSource());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // final result = await _repository.getMenuItemsByRestaurant(
      //   widget.restaurantId,
      // );
      final result = await Future.wait([
        _repository.getMenuItemsByRestaurant(widget.restaurantId),
        _repository.getRestaurantById(widget.restaurantId),
      ]);

      final menuItems = result[0] as List<RestaurantMenuItemModel>;
      final restaurants = result[1] as List<RestaurantModel>;

      final foods = menuItems.expand((e) => e.items).toList();

      setState(() {
        _menuItems = menuItems;
        _restaurant = restaurants
            .where((element) => element.restaurantId == widget.restaurantId)
            .toList();
        _foods = foods;
        _isLoading = false;
      });
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_errorMessage != null) {
      return Scaffold(body: Center(child: Text(_errorMessage!)));
    }
    return Scaffold(
      appBar: AppBar(title: Text("name")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              _isLoading
                  ? CircularProgressIndicator()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        _restaurant[0].restaurantImage,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _restaurant[0].name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, size: 18, color: Colors.orange),
                        SizedBox(width: 4),
                        Text("4.8"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text(
                _restaurant[0].description,
                style: TextStyle(color: Colors.grey.shade600, height: 1.5),
              ),
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  Text(_menuItems.length.toString(), style: TextStyle(color: Colors.grey)),
                ],
              ),

              _menuItems.isEmpty
                  ? Center(child: Text("Menuda hech narsa yo'q"))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 12),
                      itemCount: 7,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: .7,
                      ),
                      itemBuilder: (context, index) {
                        return FoodCardWidget(
                          name: "Double Burger",
                          image: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
                          price: "45 000 so'm",
                          rating: 4.8,
                          duration: "15 min",
                          onTap: () {},
                          onAdd: () {},
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

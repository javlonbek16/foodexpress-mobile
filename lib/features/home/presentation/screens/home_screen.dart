import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/expandable_text.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeRepository _repository;

  bool _isLoading = true;
  String? _errorMessage;
  List<CategoryModel> _categories = [];
  List<MenuItemModel> _menuItems = [];

  @override
  void initState() {
    super.initState();

    _repository = HomeRepositoryImpl(HomeRemoteDataSource());

    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([_repository.getCategories(), _repository.getMenuItems()]);

      setState(() {
        _categories = results[0] as List<CategoryModel>;
        _menuItems = results[1] as List<MenuItemModel>;
        _isLoading = false;
      });
    } catch (e, s) {
      setState(() {
        _errorMessage = e.toString() + s.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FOOD EXPRESS MOBILE"), centerTitle: true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Xatolik yuz berdi:\n$_errorMessage", textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                _loadData();
              },
              child: const Text("Qayta urinish"),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 200,
              child: ColoredBox(color: Colors.red),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kategoriyalar", style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 80,
              child: _categories.isEmpty
                  ? const Center(child: Text("Kategoriyalar topilmadi"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Column(
                          children: [
                            const CircleAvatar(radius: 20),
                            SizedBox(
                              width: 70,
                              child: Text(
                                category.categoryName,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                    ),
            ),

            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mashhur taomlar", style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 250,
              child: _menuItems.isEmpty
                  ? const Center(child: Text("Taomlar topilmadi"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _menuItems.length,
                      itemBuilder: (context, index) {
                        final menuItem = _menuItems[index];
                        final price = double.tryParse(menuItem.price) ?? 0;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber[100],
                          ),
                          width: 300,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Image.network(
                                menuItem.imageUrl,
                                fit: BoxFit.cover,
                                height: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  print("$error");
                                  return const Placeholder(fallbackHeight: 100);
                                },
                              ),
                              const SizedBox(height: 8),

                              Text(
                                menuItem.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ExpandableText(text: menuItem.description),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${NumberFormat('#,##0.##').format(price)} so'm"),
                                  Text(menuItem.deliveryTime),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove),
                                  ),
                                  FilledButton(onPressed: () {}, child: const Text("Qo'shish")),
                                  IconButton.filledTonal(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

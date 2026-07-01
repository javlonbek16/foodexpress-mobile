import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';
import 'package:foodexpress_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/restaurant_details_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeRepository _repository;

  late PageController pageController = PageController();
  late final Timer _timer;

  bool _isLoading = true;
  String? _errorMessage;
  List<BannerModel> _banners = [];
  List<CategoryModel> _categories = [];
  List<RestaurantModel> _restaurants = [];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _repository = HomeRepositoryImpl(HomeRemoteDataSource());

    _loadData();

    pageController = PageController(viewportFraction: 0.96);

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!pageController.hasClients || _banners.isEmpty) return;

      currentPage++;

      if (currentPage >= _banners.length) {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _repository.getBanners(),
        _repository.getCategories(),
        _repository.getRestaurant(),
      ]);

      setState(() {
        _banners = results[0] as List<BannerModel>;
        _categories = results[1] as List<CategoryModel>;
        _restaurants = results[2] as List<RestaurantModel>;
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
            SizedBox(
              height: 200,
              child: PageView.builder(
                clipBehavior: Clip.none,
                controller: pageController,
                itemCount: _banners.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final banner = _banners[index];

                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(banner.imageUrl, fit: BoxFit.cover),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withAlpha(89), Colors.transparent],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            SmoothPageIndicator(
              controller: pageController,
              count: _banners.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.orange,
                dotColor: Colors.grey.shade300,
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 4,
                spacing: 6,
              ),
              onDotClicked: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
            ),
            const SizedBox(height: 20),

            const ListTile(
              title: Text(
                "Kategoriyalar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 52,
              child: _categories.isEmpty
                  ? const Center(child: Text("Kategoriyalar topilmadi"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Material(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Center(
                                child: Text(
                                  category.categoryName,
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),
            const ListTile(
              title: Text(
                "Restoranlar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 300,
              child: _restaurants.isEmpty
                  ? const Center(child: Text("Restoranlar topilmadi"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _restaurants.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final restaurant = _restaurants[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RestaurantDetailsScreen(restaurantId: restaurant.restaurantId),
                              ),
                            );
                          },
                          child: Container(
                            width: 285,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: restaurant.restaurantId,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image.network(
                                        restaurant.restaurantImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          restaurant.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Text(
                                          restaurant.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                            height: 1.4,
                                          ),
                                        ),

                                        const Spacer(),

                                        Row(
                                          children: [
                                            Text(
                                              "View menu",
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 18,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

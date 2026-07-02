import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/di/injection_container.dart';
import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';
import 'package:foodexpress_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_section.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/category_section.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/general_category_widget.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_card_widget.dart';

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

    _repository = HomeRepositoryImpl(sl<HomeRemoteDataSource>());

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
      appBar: AppBar(
        title: const Text("FOOD EXPRESS MOBILE"),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
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
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocProvider(
                      create: (context) => sl<BannerBloc>()..add(BannerFetched()),
                      child: BannerSection(pageController: pageController),
                    ),
                    const SizedBox(height: 20),

                    // const ListTile(
                    //   title: Text(
                    //     "Kategoriyalar",
                    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    //   ),
                    //   contentPadding: EdgeInsets.zero,
                    // ),
                    // const SizedBox(height: 10),

                    // SizedBox(
                    //   height: 52,
                    //   child: _categories.isEmpty
                    //       ? const Center(child: Text("Kategoriyalar topilmadi"))
                    //       : ListView.separated(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: _categories.length,
                    //           separatorBuilder: (_, _) => const SizedBox(width: 10),
                    //           itemBuilder: (context, index) {
                    //             final category = _categories[index];
                    //             return GeneralCategoryWidget(category: category);
                    //           },
                    //         ),
                    // ),
                    BlocProvider(
                      create: (context) => sl<CategoryBloc>(),
                      child: CategorySection(categories: _categories),
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

                                return RestaurantCardWidget(restaurant: restaurant);
                              },
                            ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }
}

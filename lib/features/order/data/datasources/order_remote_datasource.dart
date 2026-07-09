// import 'package:dio/dio.dart';
// import 'package:foodexpress_mobile/core/network/dio_client.dart';
// import 'package:foodexpress_mobile/core/network/network_executor.dart';
// import 'package:foodexpress_mobile/features/order/data/models/order_model.dart';

// class OrderRemoteDatasource {
//   final Dio dio;

//   OrderRemoteDatasource(DioClient client) : dio = client.dio;

//   Future<List<OrderModel>> getOrders() async {
//     return NetworkExecutor.execute(() async {
//       final response = await dio.get("/orders");

//       return (response.data as List).map((e) => OrderModel.fromJson(e)).toList();
//     });
//   }

//   Future<List<>>
// }

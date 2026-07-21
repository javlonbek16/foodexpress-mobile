import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/infrastructure/network/network_executor.dart';
import 'package:foodexpress_mobile/infrastructure/models/order/order_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/order/order_request_model.dart';

class OrderApiService {
  final Dio dio;

  OrderApiService(DioClient client) : dio = client.dio;

  Future<dynamic> getOrders() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.orderApi);
      print(response.data);

      return (response.data as List).map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  Future<dynamic> postOrder(OrderRequestModel request) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.post(AppEndpoints.orderApi, data: request.toJson());

      return OrderModel.fromJson(response.data);
    });
  }
}

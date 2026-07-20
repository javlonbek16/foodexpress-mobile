import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/core/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/core/network/dio_client.dart';
import 'package:foodexpress_mobile/core/network/network_executor.dart';
import 'package:foodexpress_mobile/features/order/data/models/order_model.dart';
import 'package:foodexpress_mobile/features/order/data/models/order_request_model.dart';

class OrderRemoteDatasource {
  final Dio dio;

  OrderRemoteDatasource(DioClient client) : dio = client.dio;

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

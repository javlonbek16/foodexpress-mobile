import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_state.dart';
import 'package:foodexpress_mobile/features/order/presentation/widgets/order_card_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buyurtmalarim"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(child: const CircularProgressIndicator());
                }
                if (state.orders.isEmpty) {
                  return Center(child: Text("Buyurtmalar ro'yxati bo'sh"));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.orders.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return OrderCardWidget(order: order);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

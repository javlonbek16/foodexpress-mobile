import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/core/extensions/price_extension.dart';
import 'package:foodexpress_mobile/features/order/data/models/order_model.dart';
import 'package:foodexpress_mobile/features/order/presentation/widgets/order_status_widget.dart';
import 'package:intl/intl.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;

  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(order.createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long_rounded),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  "Order #${order.id}",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              OrderStatusWidget(text: order.status, color: Colors.green),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(),

          const SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.storefront_outlined, size: 18),
              SizedBox(width: 8),
              Expanded(child: Text(order.restaurantName ?? "Noma'lum restoran")),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 18),
              SizedBox(width: 8),
              Text(formattedDate),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.attach_money, size: 18),
              SizedBox(width: 8),
              Text(order.totalPrice.formattedPrice),
            ],
          ),
        ],
      ),
    );
  }
}

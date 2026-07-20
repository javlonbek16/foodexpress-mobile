import 'package:intl/intl.dart';

extension PriceExtension on num {
  String get formattedPrice {
    final formatter = NumberFormat('#,##0', 'en_US');
    return '${formatter.format(this).replaceAll(',', ' ')} so\'m';
  }
}

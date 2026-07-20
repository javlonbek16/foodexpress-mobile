import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class CartConstants {
  static final cartBox = dotenv.env["CART_BOX"]!;
  static final cartKey = dotenv.env["CART_ITEMS_KEY"]!;
}

import 'cart_itam.dart';

class CartResponse {
  final List<CartItem> cartItems;
  final int payablePrice;
  final int totalPrice;
  final int shippingPrice;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItem.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingPrice = json['shipping_cost'];
}

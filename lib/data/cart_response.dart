import 'cart_itam.dart';

class CartResponse {
  final List<CartItem> cartItems;
   int payablePrice;
   int totalPrice;
   int shippingPrice;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItem.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingPrice = json['shipping_cost'];
}

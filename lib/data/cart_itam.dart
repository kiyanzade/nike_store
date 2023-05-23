import 'package:nike_store/data/product.dart';

class CartItem {
  final int cartItemtId;
  final Product product;
  final int count;

  CartItem(this.cartItemtId, this.product, this.count);

  CartItem.fromJson(Map<String, dynamic> json)
      : cartItemtId = json['cart_item_id'],
        product = Product.fromJson(json['product']),  // ....
        count = json['count'];
}

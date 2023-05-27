import 'package:nike_store/data/product.dart';

class CartItem {
  final int cartItemtId;
  final Product product;
  int count;
  bool deleteButtonLoading = false;
  bool changeCountLoading = false;

  CartItem(this.cartItemtId, this.product, this.count);

  CartItem.fromJson(Map<String, dynamic> json)
      : cartItemtId = json['cart_item_id'],
        product = Product.fromJson(json['product']), // ....
        count = json['count'];

  static List<CartItem> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItem> cartItems = [];
    jsonArray.forEach(
      (element) {
        cartItems.add(CartItem.fromJson(element));
      },
    );

    return cartItems;
  }
}

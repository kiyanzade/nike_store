class CartResponse {
  final int cartItemId; // شناسه محصول داخل سبد خرید کاربر
  final int productId;
  final int count;

  CartResponse(this.cartItemId, this.productId, this.count);
  CartResponse.fromJSON(Map<String, dynamic> json)
      : cartItemId = json['id'],
        productId = json['product_id'],
        count = json['count'];
}

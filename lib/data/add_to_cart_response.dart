class AddToCartResponse {
  final int cartItemId; // شناسه محصول داخل سبد خرید کاربر
  final int productId;
  final int count;

  AddToCartResponse(this.cartItemId, this.productId, this.count);
  AddToCartResponse.fromJSON(Map<String, dynamic> json)
      : cartItemId = json['id'],
        productId = json['product_id'],
        count = json['count'];
}

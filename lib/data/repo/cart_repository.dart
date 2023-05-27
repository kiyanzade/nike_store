import 'package:flutter/foundation.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/add_to_cart_response.dart';
import 'package:nike_store/data/cart_response.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/data/source/cart_data_source.dart';
import 'package:nike_store/data/source/product_data_source.dart';

import '../cart_itam.dart';

final ICartRepository cartRepository =
    CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> add(
    int productId,
  );
  Future<void> delete(
    int cartItemId,
  );
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRepository extends ICartRepository {
  final ICartDataSource cartDataSource;
  static ValueNotifier<int> cartItemCountNotifier = ValueNotifier(0);
  CartRepository(this.cartDataSource);

  @override
  Future<AddToCartResponse> add(int productId) {
    return cartDataSource.add(productId);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
    return cartDataSource.changeCount(cartItemId, count);
  }

  @override
  Future<int> count() async {
    int count = await cartDataSource.count();
    cartItemCountNotifier.value = count;
    return count;
  }

  @override
  Future<void> delete(int cartItemId) {
    return cartDataSource.delete(cartItemId);
  }

  @override
  Future<CartResponse> getAll() {
    return cartDataSource.getAll();
  }
}

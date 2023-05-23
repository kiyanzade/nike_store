import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/cart_response.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/data/source/cart_data_source.dart';
import 'package:nike_store/data/source/product_data_source.dart';

import '../cart_itam.dart';

final ICartRepository cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<CartResponse> add(
    int productId,
  );
  Future<CartResponse> delete(
    int cartItemId,
  );
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<List<CartItem>> getAll();
}

class CartRepository extends ICartRepository {
  final ICartDataSource cartDataSource;

  CartRepository(this.cartDataSource);

  @override
  Future<CartResponse> add(int productId) {
    return cartDataSource.add(productId);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    return cartDataSource.changeCount(cartItemId, count);
  }

  @override
  Future<int> count() {
    return cartDataSource.count();
  }

  @override
  Future<CartResponse> delete(int cartItemId) {
    return cartDataSource.delete(cartItemId);
  }

  @override
  Future<List<CartItem>> getAll() {
    return cartDataSource.getAll();
  }
}

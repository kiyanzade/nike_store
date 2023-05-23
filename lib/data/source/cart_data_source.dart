import 'package:dio/dio.dart';

import '../cart_itam.dart';
import '../cart_response.dart';

abstract class ICartDataSource {
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

class CartRemoteDataSource extends ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<CartResponse> add(int productId) async {
    final response =
        await httpClient.post("cart/add", data: {"product_id": productId});

    return CartResponse.fromJSON(response.data);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartItem>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}

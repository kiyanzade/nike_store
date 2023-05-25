import 'package:dio/dio.dart';
import 'package:nike_store/data/cart_response.dart';

import '../cart_itam.dart';
import '../add_to_cart_response.dart';

abstract class ICartDataSource {
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

class CartRemoteDataSource extends ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<AddToCartResponse> add(int productId) async {
    final response =
        await httpClient.post("cart/add", data: {"product_id": productId});

    return AddToCartResponse.fromJSON(response.data);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId)async {
  await httpClient.post("cart/remove",data: {"cart_item_id": cartItemId});
  }

  @override
  Future<CartResponse> getAll() async {
    final response = await httpClient.get('cart/list');
    return CartResponse.fromJson(response.data);
  }
}

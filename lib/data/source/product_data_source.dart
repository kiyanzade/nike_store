import 'package:dio/dio.dart';
import 'package:nike_store/common/exceptions.dart';

import '../product.dart';

abstract class IProductDataSource {
  Future<List<Product>> getAll(int sort);
  Future<List<Product>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);

  @override
  Future<List<Product>> getAll(int sort) async {
    final response =await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
    final products =<Product> [];
    (response.data as List).forEach((element) {
      products.add(Product.fromJSON(element));
    });
    return products;
  }

  @override
  Future<List<Product>> search(String searchTerm)async {
    final response =await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);
    final products =<Product> [];
    (response.data as List).forEach((jsonObj) {
      products.add(Product.fromJSON(jsonObj));
    });
    return products;
  }

  validateResponse(Response response){
    if(response.statusCode!=200){
      throw AppException();
    }
  }
}

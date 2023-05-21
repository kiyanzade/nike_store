import 'package:dio/dio.dart';

import '../../common/exceptions.dart';
import '../banner.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    final banners = <BannerEntity>[];
    (response.data as List).forEach((jsonObj) {
      banners.add(BannerEntity.fromJSON(jsonObj));
    });
    return banners;
  }

    validateResponse(Response response){
    if(response.statusCode!=200){
      throw AppException();
    }
  }
}

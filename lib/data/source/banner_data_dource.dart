import 'package:dio/dio.dart';

import '../../common/exceptions.dart';
import '../banner.dart';

abstract class IBannerDataSource {
  Future<List<Banner>> getAll();
}

class BannerRemoteDataSource implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<Banner>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    final banners = <Banner>[];
    (response.data as List).forEach((jsonObj) {
      banners.add(Banner.fromJSON(jsonObj));
    });
    return banners;
  }

    validateResponse(Response response){
    if(response.statusCode!=200){
      throw AppExeption();
    }
  }
}

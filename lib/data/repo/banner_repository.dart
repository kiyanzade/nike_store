import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/banner_data_dource.dart';

import '../banner.dart';

final BannerRepository bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));



abstract class IBannerRepository {
  Future<List<Banner>> getAll();
}


class BannerRepository implements IBannerRepository {
final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<Banner>> getAll() {
      return dataSource.getAll();
  }


}

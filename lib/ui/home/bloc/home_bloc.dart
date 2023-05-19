import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/repo/product_repository.dart';

import '../../../data/product.dart';
import '../../../data/repo/banner_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  final BannerRepository bannerRepository;

  HomeBloc({required this.productRepository, required this.bannerRepository})
      : super(HomeLoadingState()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStartedEvent|| event is HomeRefreshEvent) {
        emit(HomeLoadingState());
        try {
          final latestProducts =
              await productRepository.getAll(ProductSort.latest);
          final popularProducts =
              await productRepository.getAll(ProductSort.popular);
          final banners = await bannerRepository.getAll();
          emit(HomeSuccessState(
              latestProducts: latestProducts,
              banners: banners,
              popularProducts: popularProducts));
        } catch (e) {
          emit(HomeErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}

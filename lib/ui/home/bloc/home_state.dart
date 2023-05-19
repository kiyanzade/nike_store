part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final AppException exception;

  const HomeErrorState({required this.exception});
  @override
 
  List<Object> get props => [exception];
}

class HomeSuccessState extends HomeState {
  final List<Product> latestProducts;
  final List<Banner> banners;
  final List<Product> popularProducts;

  HomeSuccessState({required this.latestProducts, required this.banners, required this.popularProducts});

}

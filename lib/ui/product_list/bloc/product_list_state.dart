part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListLoadingState extends ProductListState {}

class ProductListErrorState extends ProductListState {
  final AppException appException;
  @override
  List<Object> get props => [appException];
  const ProductListErrorState(this.appException);
}

class ProductListSuccessedState extends ProductListState {
  final List<Product> products;
  final int sort;
  final List<String> sortNames;
  @override
  List<Object> get props => [products, sort, sortNames];

  const ProductListSuccessedState(this.products, this.sort, this.sortNames);
}

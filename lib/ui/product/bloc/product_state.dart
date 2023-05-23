part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddtoCartButtonLoadingState extends ProductState {}

class ProductAddToCartErrorState extends ProductState {
  final AppException appException;

  ProductAddToCartErrorState(this.appException);

  @override
  List<Object> get props => [appException];
}

class ProductAddToCartSuccessState extends ProductState {}

part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final CartResponse cartResponse;

  const CartSuccessState(this.cartResponse);
}

class CartErrorState extends CartState {
  final AppException appException;

  const CartErrorState(this.appException);
}

class CartEmptyState extends CartState {}

class CartAuthRequiredState extends CartState {}
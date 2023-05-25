part of 'cart_bloc.dart';

abstract class CartState  {
  const CartState();


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
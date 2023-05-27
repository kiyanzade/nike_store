part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStartedEvent extends CartEvent {
  final AuthInfo? authInfo;

  const CartStartedEvent(this.authInfo);
}

class CartDeleteButtonClickedEvent extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonClickedEvent(this.cartItemId);
  @override
  List<Object> get props => [cartItemId];
}

class CartAuthInfoChangedEvent extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChangedEvent(this.authInfo);
}

class CartPlusCountButtonClickedEvent extends CartEvent {
  final int cartItemId;
  @override
  List<Object> get props => [cartItemId];
  const CartPlusCountButtonClickedEvent(this.cartItemId);
}

class CartMinusCountButtonClickedEvent extends CartEvent {
  final int cartItemId;
  @override
  List<Object> get props => [cartItemId];
  const CartMinusCountButtonClickedEvent(this.cartItemId);
}

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

class CartDeleteButtonEvent extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonEvent(this.cartItemId);
@override
   List<Object> get props => [cartItemId];
}

class CartAuthInfoChangedEvent extends CartEvent {
final AuthInfo? authInfo;

  const CartAuthInfoChangedEvent(this.authInfo);
}
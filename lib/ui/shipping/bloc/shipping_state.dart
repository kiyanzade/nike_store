part of 'shipping_bloc.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

class ShippingInitial extends ShippingState {}

class ShippingLoadingState extends ShippingState {}

class ShippingErrorState extends ShippingState {
  final AppException appException;
  @override
  List<Object> get props => [appException];
  const ShippingErrorState(this.appException);
}

class ShippingSuccessState extends ShippingState {
  final CreateOrderResult result;
  @override
  List<Object> get props => [result];
  const ShippingSuccessState(this.result);
}

part of 'shipping_bloc.dart';

abstract class ShippingEvent extends Equatable {
  const ShippingEvent();

  @override
  List<Object> get props => [];
}

class ShippingCreateOrderEvent extends ShippingEvent {
  final CreateOrderParams params;

  const ShippingCreateOrderEvent(this.params);
}

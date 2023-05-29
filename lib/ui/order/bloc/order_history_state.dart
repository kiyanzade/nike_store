part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryLoadingState extends OrderHistoryState {}

class OrderHistorySuccessState extends OrderHistoryState {
  final List<OrderEntity> orders;
  @override
  List<Object> get props => [orders];
  const OrderHistorySuccessState(this.orders);
}
class OrderHistoryErrorState extends OrderHistoryState {
  final AppException exception;
@override

  List<Object> get props => [exception];
  const OrderHistoryErrorState(this.exception);
}
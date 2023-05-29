import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/repo/order_repository.dart';

import '../../../common/exceptions.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository orderRepository;
  OrderHistoryBloc(this.orderRepository) : super(OrderHistoryLoadingState()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStartedEvent) {
        try {
          emit(OrderHistoryLoadingState());
          final response = await orderRepository.getOrders();
          emit(OrderHistorySuccessState(response));
        } catch (e) {
          emit(OrderHistoryErrorState(AppException()));
        }
      }
    });
  }
}

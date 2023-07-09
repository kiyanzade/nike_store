import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/repo/order_repository.dart';


import '../../../common/exceptions.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository orderRepository;
  ShippingBloc(this.orderRepository) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit)async {
     if(event is ShippingCreateOrderEvent){
      try{
        emit(ShippingLoadingState());
        final result = await orderRepository.create(event.params);
        emit(ShippingSuccessState(result));
      }catch(e){
        emit(ShippingErrorState(AppException()));
      }
     }
    });
  }
}

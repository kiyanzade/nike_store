import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/payment_reciept.dart';
import 'package:nike_store/data/repo/order_repository.dart';

part 'payment_reciept_event.dart';
part 'payment_reciept_state.dart';

class PaymentRecieptBloc
    extends Bloc<PaymentRecieptEvent, PaymentRecieptState> {
  final IOrderRepository repository;
  PaymentRecieptBloc(this.repository) : super(PaymentRecieptLoadingState()) {
    on<PaymentRecieptEvent>((event, emit) async {
      if (event is PaymentRecieptStartedEvent) {
        try {
          emit(PaymentRecieptLoadingState());
          final result = await repository.getPaymentReciept(event.orderId);
          emit(PaymentRecieptSuccessState(result));
        } catch (e) {
          emit(PaymentRecieptErrorState(AppException()));
        }
      }
    });
  }
}

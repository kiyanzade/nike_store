part of 'payment_reciept_bloc.dart';

abstract class PaymentRecieptState extends Equatable {
  const PaymentRecieptState();
  
  @override
  List<Object> get props => [];
}

class PaymentRecieptLoadingState extends PaymentRecieptState {}

class PaymentRecieptSuccessState extends PaymentRecieptState{
  final PaymentRecieptData data;

  const PaymentRecieptSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class PaymentRecieptErrorState extends PaymentRecieptState{
final  AppException appExecution;

  const PaymentRecieptErrorState(this.appExecution);
@override
  List<Object> get props => [appExecution];
}

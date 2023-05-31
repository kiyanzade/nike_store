part of 'insert_commnet_bloc.dart';

abstract class InsertCommnetState extends Equatable {
  const InsertCommnetState();

  @override
  List<Object> get props => [];
}

class InsertCommnetInitial extends InsertCommnetState {}

class InsertCommnetLoading extends InsertCommnetState {}

class InsertCommnetError extends InsertCommnetState {
  final AppException appException;

  const InsertCommnetError(this.appException);
  @override
  List<Object> get props => [appException];
}

class InsertCommnetSuccess extends InsertCommnetState {
  final Comment comment;

  const InsertCommnetSuccess(this.comment);
  @override
  List<Object> get props => [comment];
}

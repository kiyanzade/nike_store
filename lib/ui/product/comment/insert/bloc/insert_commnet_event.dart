part of 'insert_commnet_bloc.dart';

abstract class InsertCommnetEvent extends Equatable {
  const InsertCommnetEvent();

  @override
  List<Object> get props => [];
}

class InsertCommnetSubmittedEvent extends InsertCommnetEvent {
  final String title;
  final String content;
  final int productId;
  @override
  List<Object> get props => [title, content, productId];
  const InsertCommnetSubmittedEvent(this.title, this.content, this.productId);
}

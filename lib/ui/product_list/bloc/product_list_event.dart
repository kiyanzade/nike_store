part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListStartedEvent extends ProductListEvent {
  final int sort;
  @override
  List<Object> get props => [sort];
  const ProductListStartedEvent(this.sort);
}

part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class CartAddButtonClickEvent extends ProductEvent {
  final int productId;

  CartAddButtonClickEvent(this.productId);
}

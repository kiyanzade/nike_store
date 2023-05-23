import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClickEvent) {
        try {
          emit(ProductAddtoCartButtonLoadingState());
          final result = await cartRepository.add(event.productId);
          emit(ProductAddToCartSuccessState());
        } catch (e) {
          emit(ProductAddToCartErrorState(AppException()));
        }
      }
    });
  }
}

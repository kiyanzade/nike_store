import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/cart_response.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoadingState()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStartedEvent) {
        try {
          emit(CartLoadingState());
          final cartResponse = await cartRepository.getAll();
          emit(CartSuccessState(cartResponse));
        } catch (e) {
          emit(CartErrorState(AppException()));
        }
      }
    });
  }
}

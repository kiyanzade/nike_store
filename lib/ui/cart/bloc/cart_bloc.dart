import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/cart_response.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoadingState()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStartedEvent) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessToken.isEmpty) {
          emit(CartAuthRequiredState());
        } else {
          try {
            emit(CartLoadingState());
            final cartResponse = await cartRepository.getAll();
            emit(CartSuccessState(cartResponse));
          } catch (e) {
            emit(CartErrorState(AppException()));
          }
        }
      } else if (event is CartDeleteButtonEvent) {
      } else if (event is CartAuthInfoChangedEvent) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequiredState());
        } else {
          if (state is CartAuthRequiredState)
            try {
              emit(CartLoadingState());
              final cartResponse = await cartRepository.getAll();
              emit(CartSuccessState(cartResponse));
            } catch (e) {
              emit(CartErrorState(AppException()));
            }
        }
      }
    });
  }
}

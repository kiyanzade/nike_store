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
            if (cartResponse.cartItems.isEmpty) {
              emit(CartEmptyState());
            } else {
              emit(CartSuccessState(cartResponse));
            }
          } catch (e) {
            emit(CartErrorState(AppException()));
          }
        }
      } else if (event is CartDeleteButtonClickedEvent) {
        try {
          if (state is CartSuccessState) {
            final successState = state as CartSuccessState;
            final cartItemDeleting = successState.cartResponse.cartItems
                .firstWhere(
                    (element) => element.cartItemtId == event.cartItemId);
            cartItemDeleting.deleteButtonLoading = true;
            emit(CartSuccessState(successState.cartResponse));
          }

          await cartRepository.delete(event.cartItemId);
          if (state is CartSuccessState) {
            final successState = state as CartSuccessState;
            successState.cartResponse.cartItems.removeWhere(
                (element) => element.cartItemtId == event.cartItemId);
            if (successState.cartResponse.cartItems.isEmpty)
              emit(CartEmptyState());
            else
              emit(CartSuccessState(successState.cartResponse));
          }
        } catch (e) {}
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

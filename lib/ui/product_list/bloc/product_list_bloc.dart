import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/product_repository.dart';

import '../../../data/product.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository productRepository;
  ProductListBloc(this.productRepository) : super(ProductListLoadingState()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStartedEvent) {
        try {
          emit(ProductListLoadingState());
          final response = await productRepository.getAll(event.sort);
          emit(ProductListSuccessedState(
              response, event.sort, ProductSort.names));
        } catch (e) {
          emit(ProductListErrorState(AppException()));
        }
      }
    });
  }
}

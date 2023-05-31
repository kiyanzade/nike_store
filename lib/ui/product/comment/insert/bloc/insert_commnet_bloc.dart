import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/data/repo/comment_repository.dart';

import '../../../../../common/exceptions.dart';
import '../../../../../data/comment.dart';

part 'insert_commnet_event.dart';
part 'insert_commnet_state.dart';

class InsertCommnetBloc extends Bloc<InsertCommnetEvent, InsertCommnetState> {
  final ICommentRepository commentRepository;
  final int productId;
  InsertCommnetBloc(this.commentRepository, this.productId)
      : super(InsertCommnetInitial()) {
    on<InsertCommnetEvent>((event, emit) async {
      if (event is InsertCommnetSubmittedEvent) {
        if (event.title.isNotEmpty && event.content.isNotEmpty) {
          emit(InsertCommnetLoading());
          try {
            final comment = await commentRepository.insert(
                event.title, event.content, productId);
            emit(InsertCommnetSuccess(comment));
          } catch (e) {
            emit(InsertCommnetError(AppException()));
          }
        } else {
          emit(InsertCommnetError(
              AppException(message: "لطفا اطلاعات نظر را کامل وارد کنید")));
        }
      }
    });
  }
}

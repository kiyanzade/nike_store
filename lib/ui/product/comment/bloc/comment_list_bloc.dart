import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/data/repo/comment_repository.dart';

import '../../../../common/exceptions.dart';
import '../../../../data/comment.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository commentRepository;
  final int productId;
  CommentListBloc({required this.commentRepository, required this.productId})
      : super(CommentListLoadingState()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStartedEvent) {
        emit(CommentListLoadingState());
        try {
          final comments = await commentRepository.getAll(productId: productId);
          emit(CommentListSuccessState(comments));
        } catch (e) {
          emit(CommentListErrorState(AppException()));
        }
      }
    });
  }
}

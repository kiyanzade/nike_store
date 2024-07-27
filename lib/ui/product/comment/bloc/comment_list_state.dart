part of 'comment_list_bloc.dart';

abstract class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

class CommentListLoadingState extends CommentListState {}

class CommentListSuccessState extends CommentListState {
  final List<Comment> comments;
  const CommentListSuccessState(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentListErrorState extends CommentListState {
  final AppException exception;

  const CommentListErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}

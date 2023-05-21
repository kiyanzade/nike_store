import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/comment_data_source.dart';

import '../comment.dart';

final CommentRepository commentRepository =
    CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<Comment>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource commentDataSource;

  CommentRepository(this.commentDataSource);
  @override
  Future<List<Comment>> getAll({required int productId}) {
    return commentDataSource.getAll(productId: productId);
  }
}

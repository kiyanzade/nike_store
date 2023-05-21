import 'package:dio/dio.dart';

import '../../common/exceptions.dart';
import '../comment.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getAll({required int productId});
}

class CommentRemoteDataSource implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);
  @override
  Future<List<Comment>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);
    final List<Comment> comments = [];
    (response.data as List).forEach((json) {
      comments.add(Comment.fromJson(json));
    });
    return comments;
  }

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}

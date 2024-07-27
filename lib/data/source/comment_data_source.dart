import 'package:dio/dio.dart';

import '../../common/exceptions.dart';
import '../comment.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getAll({required int productId});
  Future<Comment> insert(String title, String content, int productId);
}

class CommentRemoteDataSource implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);
  @override
  Future<List<Comment>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);
    final List<Comment> comments = [];
    for (var json in (response.data as List)) {
      comments.add(Comment.fromJson(json));
    }
    return comments;
  }

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }

  @override
  Future<Comment> insert(String title, String content, int productId) async {
    final response = await httpClient.post('comment/add', data: {
      'title': title,
      'content': content,
      'product_id': productId,
    });
    validateResponse(response);
    return Comment.fromJson(response.data);
  }
}

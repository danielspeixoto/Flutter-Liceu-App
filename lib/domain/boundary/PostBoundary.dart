import 'package:app/domain/aggregates/Post.dart';

abstract class IPostRepository {
  Future<void> createTextPost(String accessToken, String text);
  Future<void> createImagePost(
      String accessToken, String imageData, String imageTitle, String text);
  Future<void> delete(String accessToken, String postId);
  Future<Post> id(String accessToken, String postId);
  Future<void> updateRating(String accessToken, String postId);
  Future<void> updatePostComment(
      String accessToken, String postId, String comment);
  Future<List<Post>> search(String accessToken, String query);
    Future<void> deletePostComment(
      String accessToken, String postId, String commentId);
}

abstract class ISearchPostsUseCase {
  Future<List<Post>> run(String query);
}

abstract class ICreateTextPostUseCase {
  Future<void> run(String text);
}

abstract class ICreateImagePostUseCase {
  Future<void> run(String imageData, String text);
}

abstract class IDeletePostUseCase {
  Future<void> run(String postId);
}

abstract class IExploreRepository {
  Future<List<Post>> explore(String accessToken, int amount);
}

abstract class IExplorePostUseCase {
  Future<List<Post>> run(int amount);
}

abstract class IGetPostByIdUseCase {
  Future<Post> run(String postId);
}

abstract class IUpdatePostRatingUseCase {
  Future<void> run(String postId);
}

abstract class IUpdatePostCommentUseCase {
  Future<void> run(String postId, String comment);
}

abstract class IDeletePostCommentUseCase {
  Future<void> run(String postId, String commentId);
}

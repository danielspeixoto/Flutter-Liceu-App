import 'package:app/domain/aggregates/Post.dart';

abstract class IPostRepository {
  Future<void> createTextPost(String accessToken, String text);
  Future<void> createImagePost(
      String accessToken, String imageData, String imageTitle, String text);
  Future<void> delete(String accessToken, String postId);
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

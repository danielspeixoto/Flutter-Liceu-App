import 'package:app/domain/aggregates/Post.dart';

abstract class IPostRepository {
  Future<void> create(String accessToken, PostType type, String text);
}

abstract class ICreatePostUseCase {
  Future<void> run(PostType type, String text);
}

import 'package:app/domain/aggregates/Post.dart';

abstract class IPostRepository {
  Future<void> create(String accessToken, String type, String text);
}

abstract class ICreatePostUseCase {
  Future<void> run(String type, String text);
}

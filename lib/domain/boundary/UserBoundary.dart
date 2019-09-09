import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';

abstract class IUserRepository {
  Future<User> id(String accessToken, String id);
  Future<void> setDescription(String accessToken, String description);
  Future<List<User>> search(String accessToken, String query, int amount);
  Future<void> follow(String accessToken, String producerId);
  Future<void> unfollow(String accessToken, String producerId);
  Future<List<Post>> posts(String accessToken, String userId);
  Future<List<Challenge>> challenges(String accessToken, String userId);
}

abstract class IMyInfoUseCase {
  Future<User> run();
}

abstract class IIsLoggedInUseCase {
  Future<bool> run();
}

abstract class ISetUserDescriptionUseCase {
  Future<void> run(String description);
}

abstract class ISearchForUserUseCase {
  Future<void> run(String query, int amount);
}

abstract class IGetUserPostsUseCase {
  Future<List<Post>> run(String userId);
}

abstract class IGetUserChallengesUseCase {
  Future<List<Challenge>> run(String userId);
}
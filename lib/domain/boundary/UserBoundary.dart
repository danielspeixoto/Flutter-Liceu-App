import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';

abstract class IUserRepository {
  Future<User> id(String accessToken, String id);

  Future<void> setDescription(
      String accessToken, String id, String description);

  Future<void> setInstagram(String accessToken, String id, String instagram);

  Future<List<User>> search(String accessToken, String query, int amount);

  Future<void> follow(String accessToken, String producerId);

  Future<void> unfollow(String accessToken, String producerId);

  Future<List<Post>> posts(String accessToken, String userId);

  Future<List<Challenge>> challenges(String accessToken, String userId);

  Future<void> check(String accessToken, String id);
}

abstract class ICheckUseCase {
  Future<void> run();
}

abstract class IGetUserByIdUseCase {
  Future<User> run(String id);
}

abstract class IMyInfoUseCase {
  Future<User> run();
}

abstract class IMyIdUseCase {
  Future<String> run();
}

abstract class IIsLoggedInUseCase {
  Future<bool> run();
}

abstract class ILogOutUseCase {
  Future<void> run();
}

abstract class ISetUserDescriptionUseCase {
  Future<void> run(String description);
}

abstract class ISetUserInstagramUseCase {
  Future<void> run(String instagram);
}

abstract class ISearchForUserUseCase {
  Future<List<User>> run(String query, int amount);
}

abstract class IGetUserPostsUseCase {
  Future<List<Post>> run(String userId);
}

abstract class IMyPostsUseCase {
  Future<List<Post>> run();
}

abstract class IGetUserChallengesUseCase {
  Future<List<Challenge>> run(String userId);
}

abstract class IMyChallengesUseCase {
  Future<List<Challenge>> run();
}

import 'package:app/domain/aggregates/User.dart';

abstract class IUserRepository {
  Future<User> id(String accessToken, String id);
}

abstract class IMyInfoUseCase {
  Future<User> run();
}

abstract class IIsLoggedInUseCase {
  Future<bool> run();
}
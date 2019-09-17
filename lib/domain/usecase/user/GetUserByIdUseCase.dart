import 'package:app/domain/aggregates/User.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class GetUserByIdUseCase implements IGetUserByIdUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  GetUserByIdUseCase(this._userRepository, this._localRepository);

  @override
  Future<User> run(String id) async {
    final cred = await _localRepository.getCredentials();
    final user = await _userRepository.id(cred, id);
    return user;
  }
}

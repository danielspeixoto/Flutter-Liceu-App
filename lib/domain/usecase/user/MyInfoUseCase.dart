import 'package:app/domain/aggregates/User.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class MyInfoUseCase implements IMyInfoUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  MyInfoUseCase(this._userRepository, this._localRepository);

  @override
  Future<User> run() async {
    final cred = await _localRepository.getCredentials();
    final id = await _localRepository.getId();
    final user = await _userRepository.id(cred, id);
    return user;
  }
}

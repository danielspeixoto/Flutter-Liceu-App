import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class CheckUseCase implements ICheckUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  CheckUseCase(this._userRepository, this._localRepository);

  @override
  Future<void> run() async {
    final cred = await _localRepository.getCredentials();
    final id = await _localRepository.getId();
    await _userRepository.check(cred, id);
  }
}

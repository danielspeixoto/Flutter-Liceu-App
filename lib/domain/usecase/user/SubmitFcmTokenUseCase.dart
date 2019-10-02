import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SubmitFcmTokenUseCase implements ISubmitFcmTokenUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SubmitFcmTokenUseCase(
      this._localRepository, this._userRepository);

  @override
  Future<void> run(String fcmtoken, String userId) async {
    final cred = await _localRepository.getCredentials();
    _userRepository.fcmtoken(cred, fcmtoken, userId);
  }
}
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SetUserPhoneUseCase implements ISetUserPhoneUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SetUserPhoneUseCase(this._localRepository, this._userRepository);

  @override
  Future<void> run(String phone) async {
    final accessToken = await this._localRepository.getCredentials();
    final id = await this._localRepository.getId();
    await this._userRepository.setPhone(accessToken, id, phone);
  }
}
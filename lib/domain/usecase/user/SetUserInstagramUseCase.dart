import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SetUserInstagramUseCase implements ISetUserInstagramUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SetUserInstagramUseCase(this._localRepository, this._userRepository);

  @override
  Future<void> run(String instagram) async {
    final accessToken = await this._localRepository.getCredentials();
    final id = await this._localRepository.getId();
    await this._userRepository.setInstagram(accessToken, id, instagram);
  }
}

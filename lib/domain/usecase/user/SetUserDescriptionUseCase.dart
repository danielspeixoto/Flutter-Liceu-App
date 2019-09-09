import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SetUserDescriptionUseCase implements ISetUserDescriptionUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SetUserDescriptionUseCase(this._localRepository, this._userRepository);

  @override
  Future<void> run(String description) async {
    final accessToken = await this._localRepository.getCredentials();
    final id = await this._localRepository.getId();
    await this._userRepository.setDescription(accessToken, id, description);
  }


}

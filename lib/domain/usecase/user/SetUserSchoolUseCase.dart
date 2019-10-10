import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class SetUserSchoolUseCase implements ISetUserSchoolUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  SetUserSchoolUseCase(this._localRepository, this._userRepository);

  @override
  Future<void> run(String school) async {
    final accessToken = await this._localRepository.getCredentials();
    final id = await this._localRepository.getId();
    await this._userRepository.setSchool(accessToken, id, school);
  }
}
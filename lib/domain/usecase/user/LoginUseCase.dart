import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/LoginBoundary.dart';

class LoginUseCase implements ILoginUseCase {
  final ILoginRepository _loginRepository;
  final ILocalRepository _localRepository;

  LoginUseCase(this._loginRepository, this._localRepository);

  @override
  Future<String> run(String accessCode, String method) async {
    var serverAccessToken =
        await this._loginRepository.auth(accessCode, method);
    await this._localRepository.saveCredentials(serverAccessToken);
    return await this._localRepository.getId();
  }
}

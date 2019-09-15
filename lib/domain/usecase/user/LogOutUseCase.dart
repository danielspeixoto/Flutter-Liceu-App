import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class LogOutUseCase implements ILogOutUseCase {
  final ILocalRepository _localRepository;

  LogOutUseCase(this._localRepository);

  @override
  Future<void> run() async {
    return _localRepository.logOut();
  }
}

import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class IsLoggedInUseCase implements IIsLoggedInUseCase {
  final ILocalRepository _localRepository;

  IsLoggedInUseCase(this._localRepository);

  @override
  Future<bool> run() async {
    return _localRepository.isLoggedIn();
  }
}

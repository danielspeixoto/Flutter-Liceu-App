import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class MyIdUseCase implements IMyIdUseCase {
  final ILocalRepository _localRepository;

  MyIdUseCase(this._localRepository);

  @override
  Future<String> run() async {
    return _localRepository.getId();
  }
}

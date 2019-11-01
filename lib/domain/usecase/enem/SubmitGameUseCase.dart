import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class SubmitGameUseCase implements ISubmitGameUseCase {
  final IENEMGameRepository _gameRepository;
  final ILocalRepository _localRepository;

  SubmitGameUseCase(this._localRepository, this._gameRepository);


  @override
  Future<void> run(List<ENEMAnswer> answers, int timeSpent) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._gameRepository.submitGame(accessToken, answers, timeSpent);
    return;
  }

}

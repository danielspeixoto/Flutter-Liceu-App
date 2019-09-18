import 'package:app/domain/aggregates/Ranking.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/RankingBoundary.dart';

class GetCurrentRankingUseCase implements IGetCurrentRankingUseCase {
  final IRankingRepository _rankingRepository;
  final ILocalRepository _localRepository;

  GetCurrentRankingUseCase(this._localRepository, this._rankingRepository);

  @override
  Future<Ranking> run(int amount) async {
    final accessToken = await this._localRepository.getCredentials();
    final date = DateTime.now();
    final ranking = await this._rankingRepository.get(accessToken, date.month, date.year, amount);
    return ranking;
  }
}

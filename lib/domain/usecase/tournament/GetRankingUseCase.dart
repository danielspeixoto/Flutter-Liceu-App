import 'package:app/domain/aggregates/Ranking.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/RankingBoundary.dart';

class GetRankingUseCase implements IGetCurrentRankingUseCase {
  final IRankingRepository _rankingRepository;
  final ILocalRepository _localRepository;

  GetRankingUseCase(this._localRepository, this._rankingRepository);

  @override
  Future<Ranking> run(int amount) async {
    final accessToken = await this._localRepository.getCredentials();
    final ranking = await this._rankingRepository.get(accessToken, 8, 2019, amount);
    return ranking;
  }
}

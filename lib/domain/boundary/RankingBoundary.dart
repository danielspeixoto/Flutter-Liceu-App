import 'package:app/domain/aggregates/Ranking.dart';

abstract class IRankingRepository {
  Future<Ranking> get(String accessToken, int month, int year, int amount);
}

abstract class IGetCurrentRankingUseCase {
  Future<Ranking> run(int amount);
}
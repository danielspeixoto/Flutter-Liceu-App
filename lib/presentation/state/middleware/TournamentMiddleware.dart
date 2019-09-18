import 'package:app/domain/boundary/RankingBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/aggregates/GameData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import 'package:app/presentation/state/actions/TournamentActions.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

List<Middleware<AppState>> tournamentMiddleware(
  IGetCurrentRankingUseCase getRankingUseCase,
  IGetUserByIdUseCase getUserById,
) {

  void fetchRanking(Store<AppState> store, FetchRankingAction action,
      NextDispatcher next) async {
    try {
      final ranking = await getRankingUseCase.run(30);
      final futures = ranking.games.map((game) async {
        final user = await getUserById.run(game.userId);
        return GameData(
          game.id,
          user,
          game.answers,
          game.timeSpent
        );
      });
      final rankingData = RankingData(await Future.wait(futures));
      store.dispatch(SetRankingAction(rankingData));
    } catch (e) {
      print(e);
    }
  }

  return [
    TypedMiddleware<AppState, FetchRankingAction>(fetchRanking),
  ];
}


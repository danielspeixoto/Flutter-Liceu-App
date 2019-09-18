import 'package:app/domain/aggregates/Ranking.dart';
import 'package:app/presentation/state/actions/TournamentActions.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import 'package:redux/redux.dart';

import '../../constants.dart';
import 'Data.dart';

class TournamentState {
  final Data<RankingData> ranking;

  TournamentState(this.ranking);

  factory TournamentState.initial() => TournamentState(
        Data(),
      );

  TournamentState copyWith({
    Data<RankingData> ranking,
  }) {
    final state = TournamentState(
      ranking ?? this.ranking,
    );
    return state;
  }
}

final Reducer<TournamentState> tournamentReducer = combineReducers<TournamentState>([
  TypedReducer<TournamentState, FetchRankingAction>(fetchingRanking),
  TypedReducer<TournamentState, SetRankingAction>(setProfileData),
  TypedReducer<TournamentState, FetchingRankingErrorAction>(fetchingRankingError),
]);

TournamentState fetchingRanking(TournamentState state, FetchRankingAction action) {
  return state.copyWith(ranking: state.ranking.copyWith(isLoading: true, errorMessage: ""));
}

TournamentState fetchingRankingError(TournamentState state, FetchingRankingErrorAction action) {
  return state.copyWith(ranking: state.ranking.copyWith(isLoading: false, errorMessage: DEFAULT_ERROR_MESSAGE));
}


TournamentState setProfileData(TournamentState state, SetRankingAction action) {
  return state.copyWith(ranking: Data(content: action.ranking, isLoading: false));
}

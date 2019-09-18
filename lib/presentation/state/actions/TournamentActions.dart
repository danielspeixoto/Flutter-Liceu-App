import 'package:app/presentation/state/aggregates/RankingData.dart';

import '../../constants.dart';

class FetchRankingAction {
  FetchRankingAction();
}

class FetchingRankingErrorAction {
  final String error;

  FetchingRankingErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class SetRankingAction {
  final RankingData ranking;

  SetRankingAction(this.ranking);
}

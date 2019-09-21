import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class GameViewModel {
  final Data<List<ChallengeHistoryData>> challenges;
  final Function refresh;
  final Function onChallengePressed;
  final Function onTrainingPressed;

  GameViewModel({
    this.challenges,
    this.refresh,
    this.onChallengePressed,
    this.onTrainingPressed,
  });

  factory GameViewModel.create(Store<AppState> store) {
    return GameViewModel(
      challenges: store.state.userState.challenges,
      refresh: () => store.dispatch(FetchMyChallengesAction()),
      onChallengePressed: () => store.dispatch(ChallengeAction()),
      onTrainingPressed: () => store.dispatch(TrainingAction()),
    );
  }
}

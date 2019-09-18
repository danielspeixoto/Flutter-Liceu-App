import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class GameViewModel {

  final Data<List<ChallengeHistoryData>> challenges;
  final Function refresh;

  GameViewModel({this.challenges, this.refresh});

  factory GameViewModel.create(Store<AppState> store) {
    return GameViewModel(
      challenges: store.state.userState.challenges,
      refresh: () =>
          store.dispatch(FetchMyChallengesAction())
    );
  }
}

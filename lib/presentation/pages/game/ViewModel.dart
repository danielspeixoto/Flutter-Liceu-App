import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
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
  final Function onTournamentPressed;
  final Function onCreateTriviaPressed;
  final Function(User user) onUserPressed;

  GameViewModel({
    this.challenges,
    this.refresh,
    this.onChallengePressed,
    this.onTrainingPressed,
    this.onTournamentPressed,
    this.onCreateTriviaPressed,
    this.onUserPressed,
  });

  factory GameViewModel.create(Store<AppState> store) {
    return GameViewModel(
      challenges: store.state.userState.challenges,
      refresh: () => store.dispatch(FetchUserChallengesAction()),
      onChallengePressed: () {
        store.dispatch(NavigateChallengeAction());
        store.dispatch(FetchRandomChallengeAction());
      },
      onTrainingPressed: () =>
          store.dispatch(NavigateTrainingQuestionsAction()),
      onTournamentPressed: () => store.dispatch(NavigateTournamentAction()),
      onCreateTriviaPressed: () => store.dispatch(NavigateCreateTriviaAction()),
      onUserPressed: (user) => store.dispatch(NavigateViewFriendAction(user)),
    );
  }
}

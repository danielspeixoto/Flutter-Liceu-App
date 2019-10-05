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
import 'package:share/share.dart';

class GameViewModel {
  final Data<List<ChallengeHistoryData>> challenges;
  final Function refresh;
  final Function onChallengePressed;
  final Function onTrainingPressed;
  final Function onTournamentPressed;
  final Function onCreateTriviaPressed;
  final Function(User user) onUserPressed;
  final Function onChallengeFriendPressed;

  GameViewModel({
    this.challenges,
    this.refresh,
    this.onChallengePressed,
    this.onTrainingPressed,
    this.onTournamentPressed,
    this.onCreateTriviaPressed,
    this.onUserPressed,
    this.onChallengeFriendPressed,
  });

  factory GameViewModel.create(Store<AppState> store) {
    return GameViewModel(
      challenges: store.state.userState.challenges,
      refresh: () => store.dispatch(FetchUserChallengesAction()),
      onChallengePressed: () {
        store.dispatch(PlayRandomChallengeAction());
      },
      onTrainingPressed: () {
        store.dispatch(StartTrainingAction());
      },
      onTournamentPressed: () => store.dispatch(StartTournamentAction()),
      onCreateTriviaPressed: () => store.dispatch(NavigateCreateTriviaAction()),
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
      onChallengeFriendPressed: () {
        store.dispatch(ChallengeMeAction());
        Share.share(
            "Você é capaz de acertar mais questões?\nhttps://liceu.co?userId=${store.state.userState.user.content.id}");
      },
    );
  }
}

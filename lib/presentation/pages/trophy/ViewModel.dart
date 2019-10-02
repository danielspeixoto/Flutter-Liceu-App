import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TrophyEntry {
  final User user;
  final String timeSpent;
  final String score;
  final int position;

  TrophyEntry(this.user, this.timeSpent, this.score, this.position);
}

class TrophyViewModel {
  final Data<List<TrophyEntry>> rankingData;

  final Function(User user) onUserPressed;

  TrophyViewModel({this.rankingData, this.onUserPressed});

  factory TrophyViewModel.create(Store<AppState> store) {
    final ranking = store.state.enemState.ranking;

    var position = 1;

    return TrophyViewModel(
      rankingData: Data(
          isLoading: ranking.isLoading,
          errorMessage: ranking.errorMessage,
          content: ranking.content == null
              ? null
              : ranking.content.games.map((game) {
                  var score = 0;
                  game.answers.forEach((ENEMAnswer answer) {
                    if (answer.correctAnswer == answer.selectedAnswer) {
                      score++;
                    }
                  });

                  var seconds = (game.timeSpent % 60).floor().toString();
                  if (seconds.length == 1) {
                    seconds = "0" + seconds;
                  }

                  return TrophyEntry(
                      game.user,
                      (game.timeSpent / 60).floor().toString() + ":" + seconds,
                      score.toString(),
                      position++);
                }).toList()),
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
    );
  }
}

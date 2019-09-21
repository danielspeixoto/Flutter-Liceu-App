import 'dart:math';

import 'package:app/domain/aggregates/Game.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';

class TrophyEntry {
  final String name;
  final String pictureURL;
  final String timeSpent;
  final String score;
  final int position;

  TrophyEntry(this.name, this.pictureURL, this.timeSpent, this.score, this.position);
}

class TrophyViewModel {
  final Data<List<TrophyEntry>> rankingData;

  TrophyViewModel({this.rankingData});

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
                  game.answers.forEach((Answer answer) {
                    if (answer.correctAnswer == answer.selectedAnswer) {
                      score++;
                    }
                  });

                  var seconds = (game.timeSpent % 60).floor().toString();
                  if(seconds.length == 1) {
                    seconds = "0" + seconds;
                  }

                  return TrophyEntry(
                    summarize(game.user.name, 25),
                    game.user.picURL,
                    (game.timeSpent / 60).floor().toString() +
                        ":" +
                        seconds,
                    score.toString(),
                    position++
                  );
                }).toList()),
    );
  }
}

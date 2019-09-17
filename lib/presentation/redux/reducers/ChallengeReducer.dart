import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/aggregates/ChallengeData.dart';
import 'package:app/presentation/aggregates/TriviaData.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class ChallengeState {
  final Data<ChallengeData> challenge;
  final Data<List<TriviaData>> trivias;

  ChallengeState(this.challenge, this.trivias);

  factory ChallengeState.initial() => ChallengeState(
        Data(),
        Data(),
      );

  ChallengeState copyWith({
    Data<Challenge> challenge,
    Data<List<Post>> trivias,
    Data<List<Challenge>> challenges,
  }) {
    final state = ChallengeState(
      challenge ?? this.challenge,
      trivias ?? this.trivias,
    );
    return state;
  }
}

final Reducer<ChallengeState> challengeReducer =
    combineReducers<ChallengeState>([]);
